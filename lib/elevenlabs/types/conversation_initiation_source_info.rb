# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationSourceInfo < ::Elevenlabs::Internal::Types::Model
      field :source, -> { ::Elevenlabs::Types::ConversationInitiationSource }, optional: true, nullable: true
      field :version, -> { String }, optional: true, nullable: true

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
