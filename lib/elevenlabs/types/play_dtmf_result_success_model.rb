# frozen_string_literal: true

module Elevenlabs
  module Types
    class PlayDtmfResultSuccessModel < ::Elevenlabs::Internal::Types::Model
      field :result_type, -> { ::Elevenlabs::Types::PlayDtmfResultSuccessModelResultType }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::PlayDtmfResultSuccessModelStatus }, optional: true, nullable: false
      field :dtmf_tones, -> { String }, optional: false, nullable: false
      field :reason, -> { String }, optional: true, nullable: true

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
