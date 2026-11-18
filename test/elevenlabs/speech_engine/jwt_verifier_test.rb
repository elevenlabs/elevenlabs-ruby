# frozen_string_literal: true

require 'minitest/autorun'
require 'openssl'
require 'base64'
require 'json'
require 'elevenlabs/speech_engine/jwt_verifier'

module Elevenlabs
  module SpeechEngine
    class JwtVerifierTest < Minitest::Test
      # Shared cross-SDK golden vector. `exp` is far in the future so the token
      # stays valid forever; every ElevenLabs SDK must accept this exact (api_key,
      # token) pair. Generated with secret = sha256(api_key), HS256.
      API_KEY = 'sk_0123456789abcdef0123456789abcdef'
      TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9' \
              '.eyJpc3MiOiJodHRwczovL2FwaS5lbGV2ZW5sYWJzLmlvL2NvbnZhaS9zcGVlY2gtZW5naW5lIiwic3ViIjoiY29udmFpX3NwZWVjaF9lbmdpbmVfdXBzdHJlYW0iLCJpYXQiOjEyMzQ1Njc4OTAsImV4cCI6NDEwMjQ0NDgwMH0' \
              '.UObM4hx1W8NvGViU3aqPv1-IEXhmXgWDgoS9RZZWILk'

      def test_golden_vector_verifies_and_decodes
        claims = JwtVerifier.verify(TOKEN, API_KEY)

        assert_equal 'https://api.elevenlabs.io/convai/speech-engine', claims['iss']
        assert_equal 'convai_speech_engine_upstream', claims['sub']
        assert_equal 4_102_444_800, claims['exp']
      end

      def test_bearer_prefix_is_accepted
        claims = JwtVerifier.verify("Bearer #{TOKEN}", API_KEY)

        assert_equal 'convai_speech_engine_upstream', claims['sub']
      end

      def test_residency_key_normalizes_to_base_key
        claims = JwtVerifier.verify(TOKEN, "#{API_KEY}_residency_in")

        assert_equal 'convai_speech_engine_upstream', claims['sub']
      end

      def test_wrong_api_key_is_rejected
        error = assert_raises(::Elevenlabs::Errors::BadRequestError) do
          JwtVerifier.verify(TOKEN, 'sk_wrongwrongwrongwrongwrongwrongwrong')
        end
        assert_includes error.message, 'signature mismatch'
      end

      def test_tampered_payload_is_rejected
        header_b64, _payload, signature_b64 = TOKEN.split('.')
        forged = b64url(
          '{"iss":"https://api.elevenlabs.io/convai/speech-engine",' \
          '"sub":"evil","iat":1234567890,"exp":4102444800}',
        )

        error = assert_raises(::Elevenlabs::Errors::BadRequestError) do
          JwtVerifier.verify("#{header_b64}.#{forged}.#{signature_b64}", API_KEY)
        end
        assert_includes error.message, 'signature mismatch'
      end

      def test_expired_token_is_rejected
        token = sign('iss' => JwtVerifier::ISSUER, 'sub' => JwtVerifier::SUBJECT,
                     'iat' => Time.now.to_i - 3600, 'exp' => Time.now.to_i - 120)

        error = assert_raises(::Elevenlabs::Errors::BadRequestError) { JwtVerifier.verify(token, API_KEY) }
        assert_includes error.message, 'expired'
      end

      def test_future_issued_at_is_rejected
        token = sign('iss' => JwtVerifier::ISSUER, 'sub' => JwtVerifier::SUBJECT,
                     'iat' => Time.now.to_i + 3600, 'exp' => Time.now.to_i + 7200)

        error = assert_raises(::Elevenlabs::Errors::BadRequestError) { JwtVerifier.verify(token, API_KEY) }
        assert_includes error.message, 'iat is in the future'
      end

      def test_wrong_issuer_is_rejected
        token = sign('iss' => 'https://evil.example.com', 'sub' => JwtVerifier::SUBJECT,
                     'iat' => 1_234_567_890, 'exp' => 4_102_444_800)

        error = assert_raises(::Elevenlabs::Errors::BadRequestError) { JwtVerifier.verify(token, API_KEY) }
        assert_includes error.message, 'unexpected issuer'
      end

      def test_malformed_token_is_rejected
        error = assert_raises(::Elevenlabs::Errors::BadRequestError) { JwtVerifier.verify('not-a-jwt', API_KEY) }
        assert_includes error.message, 'expected 3 parts'
      end

      def test_missing_api_key_is_rejected
        error = assert_raises(::Elevenlabs::Errors::BadRequestError) { JwtVerifier.verify(TOKEN, '') }
        assert_includes error.message, 'No API key configured'
      end

      private

      def b64url(bytes)
        ::Base64.urlsafe_encode64(bytes, padding: false)
      end

      # Sign a payload into an HS256 JWT with the test key, mirroring how the API signs.
      def sign(claims)
        header_b64 = b64url(::JSON.generate('alg' => 'HS256', 'typ' => 'JWT'))
        payload_b64 = b64url(::JSON.generate(claims))
        secret = OpenSSL::Digest::SHA256.digest(API_KEY)
        sig = b64url(OpenSSL::HMAC.digest('SHA256', secret, "#{header_b64}.#{payload_b64}"))
        "#{header_b64}.#{payload_b64}.#{sig}"
      end
    end
  end
end
