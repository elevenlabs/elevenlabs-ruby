# frozen_string_literal: true

require 'minitest/autorun'
require 'elevenlabs/webhooks/verifier'

module Elevenlabs
  module Webhooks
    class VerifierTest < Minitest::Test
      # Shared cross-SDK golden vector. The timestamp is far in the future so it
      # stays inside the (past-only) tolerance window forever; every ElevenLabs
      # SDK must accept this exact (secret, header, body) triple.
      SECRET = 'wsec_0123456789abcdef0123456789abcdef'
      BODY = '{"type":"post_call_transcription","event_timestamp":1234567890,"data":{"agent_id":"abc123"}}'
      HEADER = 't=4102444800,v0=01fc9faf23a5c155fbab279c4e0acb2ae059a567b14c10a19bd9f99c88315e99'

      def test_golden_vector_verifies_and_decodes
        event = Verifier.construct_event(BODY, HEADER, SECRET)

        assert_equal 'post_call_transcription', event['type']
        assert_equal 1_234_567_890, event['event_timestamp']
        assert_equal 'abc123', event['data']['agent_id']
      end

      def test_current_timestamp_verifies
        timestamp = Time.now.to_i.to_s
        body = '{"type":"ping"}'
        header = "t=#{timestamp},v0=#{OpenSSL::HMAC.hexdigest('SHA256', SECRET, "#{timestamp}.#{body}")}"

        event = Verifier.construct_event(body, header, SECRET)

        assert_equal 'ping', event['type']
      end

      def test_tampered_signature_is_rejected
        header = "t=4102444800,v0=#{'0' * 64}"

        error = assert_raises(::Elevenlabs::Errors::BadRequestError) do
          Verifier.construct_event(BODY, header, SECRET)
        end
        assert_includes error.message, 'Signature hash does not match'
      end

      def test_tampered_body_is_rejected
        assert_raises(::Elevenlabs::Errors::BadRequestError) do
          Verifier.construct_event("#{BODY} ", HEADER, SECRET)
        end
      end

      def test_old_timestamp_is_rejected
        timestamp = (Time.now.to_i - (31 * 60)).to_s
        body = '{"type":"ping"}'
        header = "t=#{timestamp},v0=#{OpenSSL::HMAC.hexdigest('SHA256', SECRET, "#{timestamp}.#{body}")}"

        error = assert_raises(::Elevenlabs::Errors::BadRequestError) do
          Verifier.construct_event(body, header, SECRET)
        end
        assert_includes error.message, 'Timestamp outside the tolerance zone'
      end

      def test_missing_header_is_rejected
        error = assert_raises(::Elevenlabs::Errors::BadRequestError) do
          Verifier.construct_event(BODY, '', SECRET)
        end
        assert_includes error.message, 'Missing signature header'
      end

      def test_missing_secret_is_rejected
        error = assert_raises(::Elevenlabs::Errors::BadRequestError) do
          Verifier.construct_event(BODY, HEADER, '')
        end
        assert_includes error.message, 'Webhook secret not configured'
      end

      def test_header_without_v0_scheme_is_rejected
        error = assert_raises(::Elevenlabs::Errors::BadRequestError) do
          Verifier.construct_event(BODY, 't=4102444800', SECRET)
        end
        assert_includes error.message, 'No signature hash found with expected scheme v0'
      end
    end
  end
end
