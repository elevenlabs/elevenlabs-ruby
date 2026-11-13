# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Pvc
      module Verification
        module Captcha
          module Types
            class BodyVerifyPvcVoiceCaptchaV1VoicesPvcVoiceIDCaptchaPost < ::Elevenlabs::Internal::Types::Model
              field :recording, -> { String }, optional: false, nullable: false

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
end
