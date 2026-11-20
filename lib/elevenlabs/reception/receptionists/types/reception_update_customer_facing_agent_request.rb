# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Receptionists
      module Types
        class ReceptionUpdateCustomerFacingAgentRequest < ::Elevenlabs::Internal::Types::Model
          field :config, -> { ::Elevenlabs::Types::ReceptionCustomerFacingConfigPatch }, optional: true, nullable: true
          field :name, -> { String }, optional: true, nullable: true
          field :widget, -> { ::Elevenlabs::Types::ReceptionWidgetAppearance }, optional: true, nullable: false

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
