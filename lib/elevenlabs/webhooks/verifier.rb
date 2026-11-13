# frozen_string_literal: true

require 'json'
require 'openssl'
require_relative '../errors/api_error'
require_relative '../errors/response_error'
require_relative '../errors/client_error'

module Elevenlabs
  module Webhooks
    # Verifies ElevenLabs webhook signatures.
    #
    # ElevenLabs signs each webhook with an HMAC-SHA256 digest, sent in the
    # +ElevenLabs-Signature+ header as a compound value of the form
    # +t=<unix_timestamp>,v0=<hex_digest>+. The signed message is the timestamp
    # and the raw request body joined with a period (+<timestamp>.<raw_body>+).
    #
    # This is a hand-written helper rather than generated code: the Fern
    # generator's built-in verifier cannot parse a compound header that carries
    # both the timestamp and the signature. It is listed in +.fernignore+ so
    # regeneration leaves it in place.
    #
    # It is not loaded by +require 'elevenlabs'+; require it explicitly:
    #
    #   require 'elevenlabs/webhooks/verifier'
    #
    #   event = Elevenlabs::Webhooks::Verifier.construct_event(raw_body, sig_header, secret)
    module Verifier
      # How far in the past, in seconds, a webhook timestamp may be before it is
      # rejected as a possible replay.
      TOLERANCE_SECONDS = 30 * 60

      module_function

      # Verify a webhook signature and return the decoded event payload.
      #
      # @param raw_body [String] The raw request body, exactly as received. Must
      #   be the unparsed string: re-encoding a decoded body changes the bytes
      #   and breaks verification.
      # @param sig_header [String] The value of the +ElevenLabs-Signature+ header.
      # @param secret [String] Your webhook signing secret.
      #
      # @return [Hash] The decoded webhook event.
      #
      # @raise [::Elevenlabs::Errors::BadRequestError] If the header or secret is
      #   missing, the timestamp is outside the tolerance window, or the
      #   signature does not match.
      def construct_event(raw_body, sig_header, secret)
        raise bad_request('Missing signature header') if sig_header.nil? || sig_header.empty?
        raise bad_request('Webhook secret not configured') if secret.nil? || secret.empty?

        timestamp = nil
        signature = nil
        sig_header.split(',').each do |part|
          if part.start_with?('t=')
            timestamp = part[2..]
          elsif part.start_with?('v0=')
            signature = part
          end
        end

        raise bad_request('No signature hash found with expected scheme v0') if timestamp.nil? || timestamp.empty? || signature.nil?

        request_timestamp_ms = timestamp.to_i * 1000
        tolerance_ms = (Time.now.to_i - TOLERANCE_SECONDS) * 1000
        raise bad_request('Timestamp outside the tolerance zone') if request_timestamp_ms < tolerance_ms

        digest = "v0=#{OpenSSL::HMAC.hexdigest('SHA256', secret, "#{timestamp}.#{raw_body}")}"
        raise bad_request('Signature hash does not match the expected signature hash for payload') unless secure_compare(digest, signature)

        ::JSON.parse(raw_body)
      end

      # @api private
      def bad_request(message)
        ::Elevenlabs::Errors::BadRequestError.new(message, code: 400)
      end

      # Constant-time string comparison. Prefers +OpenSSL.fixed_length_secure_compare+
      # (Ruby 3.3+), which raises on a length mismatch, so compare lengths first and
      # fall back to a manual constant-time compare where it is unavailable.
      #
      # @api private
      def secure_compare(expected, actual)
        return false unless expected.bytesize == actual.bytesize

        if OpenSSL.respond_to?(:fixed_length_secure_compare)
          OpenSSL.fixed_length_secure_compare(expected, actual)
        else
          result = 0
          expected.bytes.zip(actual.bytes) { |a, b| result |= a ^ b }
          result.zero?
        end
      end
    end
  end
end
