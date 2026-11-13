# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Language
        module Types
          class BodyCreateDubbingLanguageTargetV1DubbingProjectProjectIDLanguagePost < ::Elevenlabs::Internal::Types::Model
            field :target_language, -> { String }, optional: false, nullable: false
            field :voice_settings, -> { ::Elevenlabs::Types::DubbingLanguageResponseVoiceSettings }, optional: true, nullable: false
            field :translations, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: true

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
    end
  end
end
