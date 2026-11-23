# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationClientDataSourceInfo < ::Elevenlabs::Internal::Types::Model
      field :source, -> { ::Elevenlabs::Types::ConversationInitiationClientDataSourceInfoSource }, optional: true, nullable: false
      field :version, -> { String }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(version, 'version', max_length: 50)
      end

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
