# frozen_string_literal: true

module Elevenlabs
  module Types
    class UserMessageInputItem < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::UserMessageInputItemType }, optional: false, nullable: false
      field :content, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::UserMessageInputItemContentItem] }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(content, 'content', min_items: 1, max_items: 6)
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
