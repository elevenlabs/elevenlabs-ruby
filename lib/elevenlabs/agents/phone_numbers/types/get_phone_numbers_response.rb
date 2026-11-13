# frozen_string_literal: true

module Elevenlabs
  module Agents
    module PhoneNumbers
      module Types
        module GetPhoneNumbersResponse
          extend ::Elevenlabs::Internal::Types::Union

          discriminant :provider
          member -> { ::Elevenlabs::Types::GetPhoneNumberTwilioResponseModel }, key: 'twilio'
          member -> { ::Elevenlabs::Types::GetPhoneNumberExotelResponseModel }, key: 'exotel'
          member -> { ::Elevenlabs::Types::GetPhoneNumberSipTrunkResponseModel }, key: 'sip_trunk'

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
