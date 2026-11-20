# frozen_string_literal: true

module Elevenlabs
  module Types
    module IngestFailure
      extend ::Elevenlabs::Internal::Types::Enum

      BLOCKED_URL = :blocked_url
      DNS_FAILURE = :dns_failure
      HOST_UNREACHABLE = :host_unreachable
      ACCESS_REFUSED = :access_refused
      CRAWL_TIMEOUT = :crawl_timeout
      NO_PAGES = :no_pages
      NO_CONTENT = :no_content
      UPSTREAM_TIMEOUT = :upstream_timeout
      UPSTREAM_ERROR = :upstream_error
      UNKNOWN = :unknown

      def self.load(str)
        coerce(::JSON.parse(str, symbolize_names: true))
      end

      def self.dump(value)
        coerced = coerce(value)
        ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
      end
    end
  end
end
