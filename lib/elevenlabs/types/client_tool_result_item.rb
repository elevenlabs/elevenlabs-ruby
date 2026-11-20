# frozen_string_literal: true

module Elevenlabs
  module Types
    class ClientToolResultItem < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ClientToolResultItemType }, optional: false, nullable: false
      field :tool_call_id, -> { String }, optional: false, nullable: false
      field :result, -> { String }, optional: false, nullable: false
      field :is_error, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :error_type, -> { ::Elevenlabs::Types::ClientToolResultItemErrorType }, optional: true, nullable: true

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
