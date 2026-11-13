# frozen_string_literal: true

module Elevenlabs
  module Types
    module ListClientInteractionsParamsSmbToolType
      extend ::Elevenlabs::Internal::Types::Enum

      LIST_CLIENT_INTERACTIONS = :list_client_interactions

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
