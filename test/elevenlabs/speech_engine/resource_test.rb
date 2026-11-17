# frozen_string_literal: true

require 'minitest/autorun'
require 'elevenlabs/speech_engine/resource'

module Elevenlabs
  module SpeechEngine
    class ResourceTest < Minitest::Test
      API_KEY = 'sk_0123456789abcdef0123456789abcdef'
      TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9' \
              '.eyJpc3MiOiJodHRwczovL2FwaS5lbGV2ZW5sYWJzLmlvL2NvbnZhaS9zcGVlY2gtZW5naW5lIiwic3ViIjoiY29udmFpX3NwZWVjaF9lbmdpbmVfdXBzdHJlYW0iLCJpYXQiOjEyMzQ1Njc4OTAsImV4cCI6NDEwMjQ0NDgwMH0' \
              '.UObM4hx1W8NvGViU3aqPv1-IEXhmXgWDgoS9RZZWILk'

      def test_verify_request_accepts_valid_header
        resource = Resource.new('seng_123', api_key: API_KEY)

        assert resource.verify_request('X-ElevenLabs-Speech-Engine-Authorization' => TOKEN)
      end

      def test_verify_request_matches_header_name_case_insensitively
        resource = Resource.new('seng_123', api_key: API_KEY)

        assert resource.verify_request('x-elevenlabs-speech-engine-authorization' => TOKEN)
      end

      def test_verify_request_accepts_list_header_value
        resource = Resource.new('seng_123', api_key: API_KEY)

        assert resource.verify_request('X-ElevenLabs-Speech-Engine-Authorization' => [TOKEN])
      end

      def test_verify_request_rejects_missing_header
        resource = Resource.new('seng_123', api_key: API_KEY)

        refute resource.verify_request({})
      end

      def test_verify_request_rejects_without_api_key
        resource = Resource.new('seng_123', api_key: nil)

        refute resource.verify_request('X-ElevenLabs-Speech-Engine-Authorization' => TOKEN)
      end

      def test_verify_request_rejects_bad_token
        resource = Resource.new('seng_123', api_key: API_KEY)

        refute resource.verify_request('X-ElevenLabs-Speech-Engine-Authorization' => 'Bearer not.a.jwt')
      end

      def test_exposes_engine_id
        resource = Resource.new('seng_123', api_key: API_KEY)

        assert_equal 'seng_123', resource.engine_id
        assert_nil resource.config
      end

      def test_create_session_returns_session
        resource = Resource.new('seng_123', api_key: API_KEY)
        session = resource.create_session(send: ->(_text) {})

        assert_instance_of Session, session
      end
    end
  end
end
