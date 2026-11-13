# frozen_string_literal: true

module Elevenlabs
  module Types
    class AttentionView < ::Elevenlabs::Internal::Types::Model
      field :attention_id, -> { String }, optional: false, nullable: false
      field :campaign_id, -> { String }, optional: false, nullable: false
      field :reason, -> { String }, optional: false, nullable: false
      field :detail, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::AttentionStatus }, optional: false, nullable: false
      field :retryable, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :resolution, -> { String }, optional: false, nullable: true
      field :created_at_unix, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix, -> { Integer }, optional: false, nullable: false

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
