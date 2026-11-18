# frozen_string_literal: true

# Flows `create_and_wait`: start an image, video or text-to-speech generation, or a template run, and
# poll until it is `completed` or `failed`.
#
# Requires the generated SDK to be loaded first (require 'elevenlabs'). It is not loaded by
# +require 'elevenlabs'+; require it explicitly:
#
#   require 'elevenlabs'
#   require 'elevenlabs/flows/create_and_wait'
#
#   generation = client.flows.image.create_and_wait(model_id: 'gpt-image-2', prompt: 'A lighthouse at dusk')
#
# Hand-written (see .fernignore), mirroring `create_and_wait` in the Python SDK and `createAndWait` in the
# TS SDK. It adds methods to the generated clients by including a module, so no generated file changes.

require 'time'

module Elevenlabs
  module Flows
    # Raised by +create_and_wait+ when a generation or template run is still unfinished after
    # +wait_timeout_in_seconds+ seconds.
    #
    # The work keeps running on the server. Resume waiting by calling +get+ with {#id} (and
    # {#template_id} for a template run), or let a webhook deliver the result.
    class FlowsWaitTimeoutError < ::Elevenlabs::Errors::ApiError
      # @return [String] The generation id, or the run id for a template run.
      attr_reader :id
      # @return [String, nil] The template id for a template run, nil for a generation.
      attr_reader :template_id
      # @return [Numeric] The timeout that ran out.
      attr_reader :wait_timeout_in_seconds
      # @return [Object] The last response received, still in progress.
      attr_reader :last_response

      def initialize(id:, wait_timeout_in_seconds:, last_response:, template_id: nil)
        @id = id
        @template_id = template_id
        @wait_timeout_in_seconds = wait_timeout_in_seconds
        @last_response = last_response
        super(
          if template_id.nil?
            "Generation #{id} is still #{status} after #{wait_timeout_in_seconds}s; " \
              'call `get` with this id to keep waiting'
          else
            "Template run #{id} of template #{template_id} is still #{status} after #{wait_timeout_in_seconds}s; " \
              'call `runs.get` with `template_id` and `run_id` to keep waiting'
          end
        )
      end

      # @return [String, nil] The status of {#last_response}.
      def status
        CreateAndWait.status_of(@last_response)
      end
    end

    # The shared polling loop behind every +create_and_wait+.
    #
    # @api private
    module CreateAndWait
      # Matches the server's shortest `Retry-After` (3s for image, audio and text), so the SDK polls no
      # faster than the server would pace it when the header is missing.
      DEFAULT_MIN_POLL_INTERVAL_SECONDS = 3.0

      # Below this, a missing server hint would turn the wait into a tight loop of status checks.
      SMALLEST_MIN_POLL_INTERVAL_SECONDS = 0.5

      # Spreads out clients that started together so their status checks don't arrive in lockstep.
      POLL_JITTER = 0.2

      TERMINAL_STATUSES = %w[completed failed].freeze

      # Seams for tests: how to sleep, read the monotonic and wall clocks, and draw jitter in [0, 1).
      DEFAULT_SLEEPER = ->(seconds) { Kernel.sleep(seconds) }
      DEFAULT_MONOTONIC = -> { Process.clock_gettime(Process::CLOCK_MONOTONIC) }
      DEFAULT_WALL_CLOCK = -> { Time.now }
      DEFAULT_RANDOM = -> { Kernel.rand }

      class << self
        attr_writer :sleeper, :monotonic, :wall_clock, :random

        def sleeper = @sleeper || DEFAULT_SLEEPER
        def monotonic = @monotonic || DEFAULT_MONOTONIC
        def wall_clock = @wall_clock || DEFAULT_WALL_CLOCK
        def random = @random || DEFAULT_RANDOM

        # Restores the real sleep, clocks and jitter.
        def reset_seams!
          @sleeper = @monotonic = @wall_clock = @random = nil
        end

        def check_wait_options!(wait_timeout_in_seconds, min_interval)
          # NaN fails every comparison, and an infinite interval would never poll, so both are rejected.
          unless min_interval.is_a?(::Numeric) && min_interval.finite? && min_interval >= SMALLEST_MIN_POLL_INTERVAL_SECONDS
            raise ::ArgumentError,
                  "min_poll_interval_in_seconds must be a finite number of at least #{SMALLEST_MIN_POLL_INTERVAL_SECONDS}s, got #{min_interval.inspect}"
          end
          # Written as `!(x >= 0)` so NaN fails too: a NaN deadline never compares as passed, so the wait
          # would silently ignore the timeout. 0 times out straight after the create; nil or
          # Float::INFINITY waits indefinitely.
          return if wait_timeout_in_seconds.nil?
          return if wait_timeout_in_seconds.is_a?(::Numeric) && wait_timeout_in_seconds >= 0

          raise ::ArgumentError, "wait_timeout_in_seconds must be at least 0s, got #{wait_timeout_in_seconds.inspect}"
        end

        # The caller's options for the status GETs: everything except body parameters, which only the
        # create takes.
        def poll_request_options(request_options)
          return request_options unless request_options.is_a?(::Hash)

          request_options.reject { |key, _| key.to_s == 'additional_body_parameters' }
        end

        # Seconds from a `Retry-After` value, given as whole seconds or an HTTP date (RFC 9110), or nil
        # if absent or unparseable. Kept here rather than calling the generated raw client's private
        # parser, which can change on any regeneration.
        def parse_retry_after(value)
          return nil if value.nil?

          value = value.strip
          return value.to_f if value.match?(/\A\d+\z/)

          retry_date = begin
            ::Time.httpdate(value)
          rescue ::ArgumentError
            begin
              ::Time.rfc2822(value)
            rescue ::ArgumentError
              nil
            end
          end
          return nil if retry_date.nil?

          [retry_date - wall_clock.call, 0.0].max
        end

        # Seconds to wait before the next GET: the server's `Retry-After`, never below `min_interval`,
        # plus 0-20% jitter.
        def poll_delay(retry_after_header, min_interval)
          retry_after = parse_retry_after(retry_after_header)
          delay = [retry_after || min_interval, min_interval].max
          delay * (1 + (random.call * POLL_JITTER))
        end

        def status_of(response)
          response.respond_to?(:status) ? response.status&.to_s : nil
        end

        def terminal?(response)
          TERMINAL_STATUSES.include?(status_of(response))
        end

        # Polls until the response is terminal. `get` returns `[response, retry_after_header]`.
        def wait(id:, first:, get:, started_at:, wait_timeout_in_seconds:, min_interval:, template_id: nil)
          response, retry_after = first
          until terminal?(response)
            delay = poll_delay(retry_after, min_interval)
            unless wait_timeout_in_seconds.nil?
              # The last sleep ends on the deadline; the GET after it takes time, so the next pass raises.
              remaining = started_at + wait_timeout_in_seconds - monotonic.call
              if remaining <= 0
                raise FlowsWaitTimeoutError.new(
                  id: id, template_id: template_id,
                  wait_timeout_in_seconds: wait_timeout_in_seconds, last_response: response
                )
              end
              delay = [delay, remaining].min
            end
            sleeper.call(delay)
            response, retry_after = get.call
          end
          response
        end

        # Calls one generated method through a client that records the raw response, so the result
        # comes back with its `Retry-After` header. The generated methods return only the decoded body.
        def call_with_retry_after(generated_client_class, raw_client)
          recorder = ResponseRecorder.new(raw_client)
          result = yield generated_client_class.new(client: recorder)
          [result, recorder.last_response&.[]('retry-after')]
        end
      end

      # Stands in for the raw HTTP client and remembers the last response it returned.
      #
      # @api private
      class ResponseRecorder
        attr_reader :last_response

        def initialize(raw_client)
          @raw_client = raw_client
          @last_response = nil
        end

        # Named like the raw client's method, which the generated code calls.
        def send(request)
          @last_response = @raw_client.send(request)
        end
      end

      # Adds +create_and_wait+ to the image, video and text-to-speech flow clients.
      module Generation
        # Start a generation and wait until it is `completed` or `failed`, then return the final
        # generation.
        #
        # Takes the same parameters as +create+. Between status checks this waits as long as the
        # server's `Retry-After` header suggests, never less than +min_poll_interval_in_seconds+. This is
        # meant for scripts and quickstarts: in production, set `webhook` on the request passed to
        # +create+ and handle the webhook event instead of holding a process open.
        #
        # A `failed` generation is returned, not raised; check `status` on the result.
        #
        # @param wait_timeout_in_seconds [Numeric, nil] Seconds to wait in total before raising
        #   {FlowsWaitTimeoutError}, which carries the generation id so you can resume with +get+. Waits
        #   indefinitely when nil (the default) or Float::INFINITY; must be at least 0 when set. Not to be
        #   confused with the client's +timeout+ or +request_options[:timeout]+, which limit each HTTP request.
        # @param min_poll_interval_in_seconds [Numeric] The shortest wait between status checks, and the
        #   wait used when the server suggests none. Must be at least 0.5. Defaults to 3.
        # @param request_options [Hash] Applied to the create call and to every status check, except
        #   +additional_body_parameters+, which only the create call gets.
        # @return [Elevenlabs::Types::MediaGenerationCompletedResponse, Elevenlabs::Types::MediaGenerationFailedResponse]
        # @raise [FlowsWaitTimeoutError] The generation was still in progress when the timeout ran out.
        # @raise [ArgumentError] An option is out of range; raised before any request is sent.
        def create_and_wait(
          wait_timeout_in_seconds: nil,
          min_poll_interval_in_seconds: DEFAULT_MIN_POLL_INTERVAL_SECONDS,
          request_options: {},
          **params
        )
          CreateAndWait.check_wait_options!(wait_timeout_in_seconds, min_poll_interval_in_seconds)
          started_at = CreateAndWait.monotonic.call
          first = CreateAndWait.call_with_retry_after(self.class, @client) do |client|
            client.create(request_options: request_options, **params)
          end
          generation_id = first[0].id
          poll_options = CreateAndWait.poll_request_options(request_options)
          CreateAndWait.wait(
            id: generation_id,
            first: first,
            get: -> {
              CreateAndWait.call_with_retry_after(self.class, @client) do |client|
                client.get(generation_id: generation_id, request_options: poll_options)
              end
            },
            started_at: started_at,
            wait_timeout_in_seconds: wait_timeout_in_seconds,
            min_interval: min_poll_interval_in_seconds,
          )
        end
      end

      # Adds +create_and_wait+ to the template runs client (+flows.templates.runs+).
      module TemplateRun
        # Start a run of a flows template and wait until its `status` is `completed` or `failed`, then
        # return the final run.
        #
        # Takes the same parameters as +create+ (+template_id:+, +inputs:+, and optionally +version_id:+
        # and +webhook:+). Between status checks this waits as long as the server's `Retry-After`
        # header suggests, never less than +min_poll_interval_in_seconds+. This is meant for scripts and
        # quickstarts: in production, pass `webhook` to +create+ and handle the `flows_template_run`
        # webhook instead of holding a process open.
        #
        # A `failed` run is returned, not raised; check `status` on the result and on each output.
        #
        # @param wait_timeout_in_seconds [Numeric, nil] Seconds to wait in total before raising
        #   {FlowsWaitTimeoutError}, which carries the run id and template id so you can resume with
        #   +get+. Waits indefinitely when nil (the default) or Float::INFINITY; must be at least 0 when
        #   set. Not to be confused with the client's +timeout+ or +request_options[:timeout]+, which
        #   limit each HTTP request.
        # @param min_poll_interval_in_seconds [Numeric] The shortest wait between status checks, and the
        #   wait used when the server suggests none. Must be at least 0.5. Defaults to 3.
        # @param request_options [Hash] Applied to the create call and to every status check, except
        #   +additional_body_parameters+, which only the create call gets.
        # @return [Elevenlabs::Types::TemplateRunResponse] The run in its terminal state.
        # @raise [FlowsWaitTimeoutError] The run was still in progress when the timeout ran out.
        # @raise [ArgumentError] An option is out of range; raised before any request is sent.
        def create_and_wait(
          wait_timeout_in_seconds: nil,
          min_poll_interval_in_seconds: DEFAULT_MIN_POLL_INTERVAL_SECONDS,
          request_options: {},
          **params
        )
          CreateAndWait.check_wait_options!(wait_timeout_in_seconds, min_poll_interval_in_seconds)
          template_id = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)[:template_id]
          raise ::ArgumentError, 'template_id is required' if template_id.nil?

          started_at = CreateAndWait.monotonic.call
          first = CreateAndWait.call_with_retry_after(self.class, @client) do |client|
            client.create(request_options: request_options, **params)
          end
          run_id = first[0].id
          poll_options = CreateAndWait.poll_request_options(request_options)
          CreateAndWait.wait(
            id: run_id,
            template_id: template_id,
            first: first,
            get: -> {
              CreateAndWait.call_with_retry_after(self.class, @client) do |client|
                client.get(template_id: template_id, run_id: run_id, request_options: poll_options)
              end
            },
            started_at: started_at,
            wait_timeout_in_seconds: wait_timeout_in_seconds,
            min_interval: min_poll_interval_in_seconds,
          )
        end
      end
    end

    Image::Client.include(CreateAndWait::Generation)
    Video::Client.include(CreateAndWait::Generation)
    TextToSpeech::Client.include(CreateAndWait::Generation)
    Templates::Runs::Client.include(CreateAndWait::TemplateRun)
  end
end
