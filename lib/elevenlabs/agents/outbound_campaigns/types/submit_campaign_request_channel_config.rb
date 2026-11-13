# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Types
        module SubmitCampaignRequestChannelConfig
          extend ::Elevenlabs::Internal::Types::Union

          discriminant :channel
          member -> { ::Elevenlabs::Types::PhoneChannelConfigInput }, key: 'phone'
          member -> { ::Elevenlabs::Types::SubmitWhatsAppChannelConfig }, key: 'whatsapp'

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
