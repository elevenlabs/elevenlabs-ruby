# frozen_string_literal: true

module Elevenlabs
  module Reception
    module BusinessProfile
      module Types
        class ReceptionUpdateAgentInfoRequest < ::Elevenlabs::Internal::Types::Model
          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
          field :business_name, -> { String }, optional: true, nullable: false
          field :business_country, -> { String }, optional: true, nullable: true
          field :business_description, -> { String }, optional: true, nullable: false
          field :timezone, -> { String }, optional: true, nullable: false
          field :currency, -> { ::Elevenlabs::Reception::BusinessProfile::Types::ReceptionUpdateAgentInfoRequestCurrency }, optional: true, nullable: false
          field :operating_hours, -> { ::Elevenlabs::Types::WorkingHours }, optional: true, nullable: false
          field :tool_call_sound, -> { ::Elevenlabs::Types::ToolCallSoundType }, optional: true, nullable: false

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
