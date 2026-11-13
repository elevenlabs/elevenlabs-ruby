# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Pvc
      module Verification
        module Captcha
          module Types
            class GetCaptchaRequest < ::Elevenlabs::Internal::Types::Model
              field :voice_id, -> { String }, optional: false, nullable: false
            end
          end
        end
      end
    end
  end
end
