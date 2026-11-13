# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Widget
      module Types
        class GetWidgetRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :conversation_signature, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
