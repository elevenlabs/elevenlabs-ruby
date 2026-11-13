# frozen_string_literal: true

module Elevenlabs
  module Types
    class CommittedTranscript < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::CommittedTranscriptMessageType }, optional: true, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :segment_index, -> { Integer }, optional: true, nullable: true

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
