# frozen_string_literal: true

module Elevenlabs
  module Types
    class VerifiedVoiceLanguageResponseModel < ::Elevenlabs::Internal::Types::Model
      field :language, -> { String }, optional: false, nullable: false
      field :model_id, -> { String }, optional: false, nullable: false
      field :accent, -> { String }, optional: true, nullable: true
      field :locale, -> { String }, optional: true, nullable: true
      field :preview_url, -> { String }, optional: true, nullable: true

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
