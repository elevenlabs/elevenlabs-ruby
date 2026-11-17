# frozen_string_literal: true

require 'json'
require 'openssl'
require 'base64'
require_relative '../errors/api_error'
require_relative '../errors/response_error'
require_relative '../errors/client_error'

module Elevenlabs
  module SpeechEngine
    # Verifies the JWT that the ElevenLabs Speech Engine API presents when it opens
    # an inbound WebSocket connection to a developer-owned Speech Engine server.
    #
    # The token arrives in the +X-ElevenLabs-Speech-Engine-Authorization+ header
    # and is an HS256 JWT whose HMAC secret is the SHA-256 hash of the account's
    # API key. Data-residency keys (+..._residency_<region>+) are signed with the
    # base key, so the suffix is stripped before hashing.
    #
    # Hand-written (see +.fernignore+): the generator has no concept of the Speech
    # Engine upstream handshake. It mirrors the verifier in the PHP, Python and
    # TypeScript SDKs so every SDK accepts the same tokens.
    module JwtVerifier
      ISSUER = 'https://api.elevenlabs.io/convai/speech-engine'
      SUBJECT = 'convai_speech_engine_upstream'

      # Clock skew, in seconds, allowed on the +exp+ and +iat+ claims.
      LEEWAY_SECONDS = 60

      module_function

      # Verify an inbound Speech Engine connection token and return its decoded
      # claims.
      #
      # @param token [String] The +X-ElevenLabs-Speech-Engine-Authorization+
      #   header value, with or without a +Bearer + prefix.
      # @param api_key [String] The account API key the engine was created with.
      #
      # @return [Hash] The decoded JWT payload (claims).
      #
      # @raise [::Elevenlabs::Errors::BadRequestError] If the API key is missing,
      #   the token is malformed, the signature does not match, or a claim
      #   (issuer, subject, exp, iat) is invalid.
      def verify(token, api_key)
        raise bad_request('No API key configured for Speech Engine verification') if api_key.nil? || api_key.empty?

        token = token.to_s.strip
        token = token[7..].to_s.strip if token.downcase.start_with?('bearer ')

        parts = token.split('.')
        raise bad_request('Invalid JWT: expected 3 parts') if parts.length != 3

        header_b64, payload_b64, signature_b64 = parts

        payload_json = base64_url_decode(payload_b64)
        raise bad_request('Invalid JWT: failed to decode payload') if payload_json.nil?

        begin
          payload = ::JSON.parse(payload_json)
        rescue ::JSON::ParserError
          raise bad_request('Invalid JWT: failed to decode payload')
        end
        raise bad_request('Invalid JWT: payload is not an object') unless payload.is_a?(::Hash)

        # HMAC secret is the SHA-256 of the residency-suffix-stripped API key.
        secret = OpenSSL::Digest::SHA256.digest(normalize_api_key_for_signing(api_key))
        expected = OpenSSL::HMAC.digest('SHA256', secret, "#{header_b64}.#{payload_b64}")
        actual = base64_url_decode(signature_b64)
        if actual.nil? || !secure_compare(expected, actual)
          raise bad_request(
            'Invalid JWT: signature mismatch — make sure the API key used by your Speech Engine ' \
            'server matches the one used to create the engine.',
          )
        end

        raise bad_request('Invalid JWT: unexpected issuer') if payload['iss'] != ISSUER
        raise bad_request('Invalid JWT: unexpected subject') if payload['sub'] != SUBJECT

        now = Time.now.to_i
        exp = payload['exp']
        iat = payload['iat']
        raise bad_request('Invalid JWT: missing exp claim') unless exp.is_a?(Integer)
        raise bad_request('Invalid JWT: missing iat claim') unless iat.is_a?(Integer)
        raise bad_request('Invalid JWT: token has expired') if exp + LEEWAY_SECONDS < now
        raise bad_request('Invalid JWT: iat is in the future') if iat - LEEWAY_SECONDS > now

        payload
      end

      # @api private
      def bad_request(message)
        ::Elevenlabs::Errors::BadRequestError.new(message, code: 400)
      end

      # @api private
      def normalize_api_key_for_signing(api_key)
        api_key.strip.sub(/_residency_[a-z0-9]+\z/, '')
      end

      # Decode a base64url string (RFC 7515), tolerating missing padding.
      #
      # @return [String, nil] The decoded bytes, or nil if the input is not valid base64url.
      #
      # @api private
      def base64_url_decode(input)
        padded = input.to_s.tr('-_', '+/')
        remainder = padded.length % 4
        padded += '=' * (4 - remainder) if remainder.positive?
        ::Base64.strict_decode64(padded)
      rescue ArgumentError
        nil
      end

      # Constant-time comparison of two byte strings.
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
