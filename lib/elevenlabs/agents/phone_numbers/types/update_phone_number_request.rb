# frozen_string_literal: true

module Elevenlabs
  module Agents
    module PhoneNumbers
      module Types
        class UpdatePhoneNumberRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: true, nullable: true
          field :label, -> { String }, optional: true, nullable: true
          field :inbound_trunk_config, -> { ::Elevenlabs::Types::InboundSipTrunkConfigRequestModel }, optional: true, nullable: false
          field :outbound_trunk_config, -> { ::Elevenlabs::Types::OutboundSipTrunkConfigRequestModel }, optional: true, nullable: false
          field :livekit_stack, -> { ::Elevenlabs::Types::LivekitStackType }, optional: true, nullable: false
          field :store_sip_messages, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
          field :environment, -> { String }, optional: true, nullable: true
          field :branch_id, -> { String }, optional: true, nullable: true

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
