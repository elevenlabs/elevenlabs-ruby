# frozen_string_literal: true

require 'minitest/autorun'
require 'webmock/minitest'
require 'elevenlabs'
require 'elevenlabs/flows/create_and_wait'

module Elevenlabs
  module Flows
    # Each case checks one wait end to end, so it asserts on the result, the sleeps and the requests together.
    class CreateAndWaitTest < Minitest::Test
      BASE = 'https://api.test'
      IMAGE = { model_id: 'gpt-image-2', prompt: 'A lighthouse at dusk' }.freeze
      # 2001-09-09T01:46:40Z, the fake wall clock's "now".
      NOW = Time.at(1_000_000_000).utc

      def setup
        @slept = []
        @clock = 0.0
        CreateAndWait.sleeper = ->(seconds) {
          @slept << seconds
          @clock += seconds
        }
        CreateAndWait.monotonic = -> { @clock }
        CreateAndWait.wall_clock = -> { NOW }
        CreateAndWait.random = -> { 0.0 }
        @client = Elevenlabs::Client.new(api_key: 'test-key', base_url: BASE, max_retries: 0)
      end

      def teardown
        CreateAndWait.reset_seams!
        WebMock.reset!
      end

      def reply(body, retry_after: nil)
        headers = { 'Content-Type' => 'application/json' }
        headers['Retry-After'] = retry_after unless retry_after.nil?
        { status: 200, body: JSON.generate(body), headers: headers }
      end

      def completed(id = 'gen_1')
        { id: id, status: 'completed', content_url: 'https://cdn.test/out.png', content_mime_type: 'image/png' }
      end

      def template_run(status)
        { id: 'run_1', template_id: 'tpl_1', version_id: 'ver_1', status: status, outputs: {} }
      end

      def test_image_polls_until_completed_honouring_retry_after_seconds
        stub_request(:post, "#{BASE}/v1/flows/image")
          .to_return(reply({ id: 'gen_1', status: 'pending' }, retry_after: '3'))
        get = stub_request(:get, "#{BASE}/v1/flows/image/gen_1")
              .to_return(reply({ id: 'gen_1', status: 'generating' }, retry_after: '7'))
              .then.to_return(reply(completed))

        result = @client.flows.image.create_and_wait(**IMAGE)

        assert_equal 'completed', result.status.to_s
        assert_equal 'gen_1', result.id
        assert_equal [3.0, 7.0], @slept
        assert_requested get, times: 2
      end

      def test_failed_generation_is_returned_not_raised
        stub_request(:post, "#{BASE}/v1/flows/video")
          .to_return(reply({ id: 'gen_1', status: 'pending' }))
        get = stub_request(:get, "#{BASE}/v1/flows/video/gen_1")
              .to_return(reply({ id: 'gen_1', status: 'failed', failure_reason: 'model_error', error_message: 'boom' }))

        result = @client.flows.video.create_and_wait(model_id: 'veo-3.1-fast-generate-001', prompt: 'Waves')

        assert_equal 'failed', result.status.to_s
        assert_equal [3.0], @slept
        assert_requested get, times: 1
      end

      def test_text_to_speech_polls_until_completed
        stub_request(:post, "#{BASE}/v1/flows/text-to-speech")
          .to_return(reply({ id: 'gen_1', status: 'pending' }, retry_after: '4'))
        stub_request(:get, "#{BASE}/v1/flows/text-to-speech/gen_1").to_return(reply(completed))

        result = @client.flows.text_to_speech.create_and_wait(model_id: 'eleven_v3', text: 'Hello', voice: 'voice_1')

        assert_equal 'completed', result.status.to_s
        assert_equal [4.0], @slept
      end

      def test_retry_after_http_date
        stub_request(:post, "#{BASE}/v1/flows/image")
          .to_return(reply({ id: 'gen_1', status: 'pending' }, retry_after: (NOW + 8).httpdate))
        stub_request(:get, "#{BASE}/v1/flows/image/gen_1").to_return(reply(completed))

        @client.flows.image.create_and_wait(**IMAGE)

        assert_equal [8.0], @slept
      end

      def test_parse_retry_after
        assert_in_delta(12.0, CreateAndWait.parse_retry_after(' 12 '))
        assert_in_delta(10.0, CreateAndWait.parse_retry_after('Sun, 09 Sep 2001 01:46:50 GMT'))
        assert_in_delta(0.0, CreateAndWait.parse_retry_after('Sun, 09 Sep 2001 01:46:30 GMT'))
        assert_nil CreateAndWait.parse_retry_after('-5')
        assert_nil CreateAndWait.parse_retry_after('not-a-date')
        assert_nil CreateAndWait.parse_retry_after(nil)
      end

      def test_poll_delay_applies_floor_and_jitter
        assert_in_delta(2.0, CreateAndWait.poll_delay(nil, 2.0))
        assert_in_delta(2.0, CreateAndWait.poll_delay('0', 2.0))
        assert_in_delta(2.0, CreateAndWait.poll_delay('not-a-date', 2.0))
        assert_in_delta(3.0, CreateAndWait.poll_delay('Sun, 09 Sep 2001 01:46:30 GMT', 3.0))
        CreateAndWait.random = -> { 0.5 }

        assert_in_delta(5.5, CreateAndWait.poll_delay('5', 1.0))
        CreateAndWait.random = -> { 0.999_999 }

        assert_operator CreateAndWait.poll_delay('5', 1.0), :<, 6.0
      end

      def test_min_poll_interval_floor_overrides_shorter_retry_after
        stub_request(:post, "#{BASE}/v1/flows/image")
          .to_return(reply({ id: 'gen_1', status: 'pending' }, retry_after: '1'))
        stub_request(:get, "#{BASE}/v1/flows/image/gen_1").to_return(reply(completed))

        @client.flows.image.create_and_wait(min_poll_interval_in_seconds: 5, **IMAGE)

        assert_equal [5.0], @slept
      end

      def test_timeout_raises_with_generation_id
        stub_request(:post, "#{BASE}/v1/flows/image")
          .to_return(reply({ id: 'gen_1', status: 'pending' }, retry_after: '30'))
        get = stub_request(:get, "#{BASE}/v1/flows/image/gen_1")
              .to_return(reply({ id: 'gen_1', status: 'generating' }, retry_after: '30'))

        error = assert_raises(FlowsWaitTimeoutError) do
          @client.flows.image.create_and_wait(wait_timeout_in_seconds: 10, **IMAGE)
        end

        assert_equal [10.0], @slept
        assert_equal 'gen_1', error.id
        assert_nil error.template_id
        assert_equal 10, error.wait_timeout_in_seconds
        assert_equal 'generating', error.status
        assert_kind_of ::Elevenlabs::Errors::ApiError, error
        assert_includes error.message, 'Generation gen_1 is still generating after 10s'
        assert_includes error.message, 'call `get` with this id to keep waiting'
        assert_requested get, times: 1
      end

      def test_zero_timeout_raises_straight_after_create
        stub_request(:post, "#{BASE}/v1/flows/image").to_return(reply({ id: 'gen_1', status: 'pending' }))
        get = stub_request(:get, "#{BASE}/v1/flows/image/gen_1")

        error = assert_raises(FlowsWaitTimeoutError) do
          @client.flows.image.create_and_wait(wait_timeout_in_seconds: 0, **IMAGE)
        end

        assert_equal 'pending', error.status
        assert_empty @slept
        assert_not_requested get
      end

      def test_infinite_timeout_waits_until_completed
        stub_request(:post, "#{BASE}/v1/flows/image").to_return(reply({ id: 'gen_1', status: 'pending' }))
        stub_request(:get, "#{BASE}/v1/flows/image/gen_1").to_return(reply(completed))

        result = @client.flows.image.create_and_wait(wait_timeout_in_seconds: Float::INFINITY, **IMAGE)

        assert_equal 'completed', result.status.to_s
        assert_equal [3.0], @slept
      end

      def test_invalid_options_are_rejected_before_any_request
        create = stub_request(:post, "#{BASE}/v1/flows/image")

        [
          { min_poll_interval_in_seconds: 0.1 },
          { min_poll_interval_in_seconds: Float::NAN },
          { min_poll_interval_in_seconds: Float::INFINITY },
          { min_poll_interval_in_seconds: '3' },
          { wait_timeout_in_seconds: -1 },
          { wait_timeout_in_seconds: Float::NAN },
          { wait_timeout_in_seconds: '10' },
        ].each do |options|
          assert_raises(ArgumentError, options.inspect) { @client.flows.image.create_and_wait(**options, **IMAGE) }
        end
        assert_not_requested create
      end

      def test_template_run_polls_until_completed
        create = stub_request(:post, "#{BASE}/v1/flows/templates/tpl_1/runs")
                 .with(body: { inputs: { prompt: 'hi' } })
                 .to_return(reply(template_run('pending'), retry_after: '2'))
        get = stub_request(:get, "#{BASE}/v1/flows/templates/tpl_1/runs/run_1")
              .to_return(reply(template_run('generating'))).then.to_return(reply(template_run('completed')))

        result = @client.flows.templates.runs.create_and_wait(template_id: 'tpl_1', inputs: { 'prompt' => 'hi' })

        assert_equal 'completed', result.status.to_s
        assert_equal [3.0, 3.0], @slept
        assert_requested create, times: 1
        assert_requested get, times: 2
      end

      def test_template_run_already_terminal_on_create_skips_polling
        stub_request(:post, "#{BASE}/v1/flows/templates/tpl_1/runs").to_return(reply(template_run('failed')))

        result = @client.flows.templates.runs.create_and_wait(template_id: 'tpl_1', inputs: {})

        assert_equal 'failed', result.status.to_s
        assert_empty @slept
      end

      def test_template_run_timeout_carries_template_id
        stub_request(:post, "#{BASE}/v1/flows/templates/tpl_1/runs").to_return(reply(template_run('pending')))
        stub_request(:get, "#{BASE}/v1/flows/templates/tpl_1/runs/run_1").to_return(reply(template_run('generating')))

        error = assert_raises(FlowsWaitTimeoutError) do
          @client.flows.templates.runs.create_and_wait(template_id: 'tpl_1', inputs: {}, wait_timeout_in_seconds: 5)
        end

        assert_equal 'run_1', error.id
        assert_equal 'tpl_1', error.template_id
        assert_equal 'generating', error.status
        assert_includes error.message, 'of template tpl_1'
        assert_includes error.message, '`runs.get` with `template_id` and `run_id`'
      end

      def test_body_parameters_go_to_create_only
        create = stub_request(:post, "#{BASE}/v1/flows/image")
                 .with(body: hash_including('extra' => 1), headers: { 'X-Test' => '1' })
                 .to_return(reply({ id: 'gen_1', status: 'pending' }))
        get = stub_request(:get, "#{BASE}/v1/flows/image/gen_1")
              .with(headers: { 'X-Test' => '1' }) { |request| request.body.nil? || request.body.empty? }
              .to_return(reply(completed))

        @client.flows.image.create_and_wait(
          request_options: { additional_body_parameters: { extra: 1 }, additional_headers: { 'X-Test' => '1' } },
          **IMAGE,
        )

        assert_requested create, times: 1
        assert_requested get, times: 1
      end
    end
    # rubocop:enable Minitest/MultipleAssertions
  end
end
