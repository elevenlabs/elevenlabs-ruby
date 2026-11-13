# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryRagUsageCommonModel < ::Elevenlabs::Internal::Types::Model
      field :usage_count, -> { Integer }, optional: false, nullable: false
      field :embedding_model, -> { String }, optional: false, nullable: false

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
