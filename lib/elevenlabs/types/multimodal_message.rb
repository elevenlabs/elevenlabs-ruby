# frozen_string_literal: true

module Elevenlabs
  module Types
    class MultimodalMessage < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::MultimodalMessageType }, optional: true, nullable: false
      field :text, -> { ::Elevenlabs::Types::MultimodalMessageText }, optional: true, nullable: false
      field :file, -> { ::Elevenlabs::Types::MultimodalMessageFile }, optional: true, nullable: false
      field :files, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::MultimodalMessageFilesItem] }, optional: true, nullable: false

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
