# frozen_string_literal: true

module Elevenlabs
  module Tokens
    module SingleUse
      module Types
        class CreateSingleUseRequest < ::Elevenlabs::Internal::Types::Model
          field :token_type, -> { ::Elevenlabs::Types::SingleUseTokenType }, optional: false, nullable: false
        end
      end
    end
  end
end
