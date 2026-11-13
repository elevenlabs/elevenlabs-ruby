# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Whatsapp
      module Types
        module BodySendAnOutboundMessageViaWhatsAppV1ConvaiWhatsappOutboundMessagePostTemplateParamsItem
          extend ::Elevenlabs::Internal::Types::Union

          discriminant :type
          member -> { ::Elevenlabs::Types::WhatsAppTemplateBodyComponentParams }, key: 'body'
          member -> { ::Elevenlabs::Types::WhatsAppTemplateButtonComponentParams }, key: 'button'
          member -> { ::Elevenlabs::Types::WhatsAppTemplateHeaderComponentParams }, key: 'header'

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
