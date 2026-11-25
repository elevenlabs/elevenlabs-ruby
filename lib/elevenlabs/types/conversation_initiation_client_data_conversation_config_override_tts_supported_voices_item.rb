# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationClientDataConversationConfigOverrideTtsSupportedVoicesItem < ::Elevenlabs::Internal::Types::Model
      field :label, -> { String }, optional: false, nullable: false
      field :voice_id, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :language, -> { String }, optional: true, nullable: false
      field :model_family, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideTtsSupportedVoicesItemModelFamily }, optional: true, nullable: false
      field :optimize_streaming_latency, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideTtsSupportedVoicesItemOptimizeStreamingLatency }, optional: true, nullable: false
      field :stability, -> { Float }, optional: true, nullable: false
      field :speed, -> { Float }, optional: true, nullable: false
      field :similarity_boost, -> { Float }, optional: true, nullable: false
      field :clone_strength, -> { Float }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(label, 'label', min_length: 1)
        ::Elevenlabs::Validator.validate_string!(voice_id, 'voice_id', min_length: 1)
        Validator.validate_number!(stability, 'stability', min: 0, max: 1)
        Validator.validate_number!(speed, 'speed', min: 0.7, max: 1.2)
        Validator.validate_number!(similarity_boost, 'similarity_boost', min: 0, max: 1)
        Validator.validate_number!(clone_strength, 'clone_strength', min: 0, max: 1)
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
