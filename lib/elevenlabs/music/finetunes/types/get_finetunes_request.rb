# frozen_string_literal: true

module Elevenlabs
  module Music
    module Finetunes
      module Types
        class GetFinetunesRequest < ::Elevenlabs::Internal::Types::Model
          field :finetune_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
