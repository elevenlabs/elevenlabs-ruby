# frozen_string_literal: true

module Elevenlabs
  module Agents
    module BatchCalls
      module Types
        class BodySubmitABatchCallRequestV1ConvaiBatchCallingSubmitPost < ::Elevenlabs::Internal::Types::Model
          field :call_name, -> { String }, optional: false, nullable: false
          field :agent_id, -> { String }, optional: false, nullable: false
          field :recipients, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::OutboundCallRecipient] }, optional: false, nullable: false
          field :scheduled_time_unix, -> { Integer }, optional: true, nullable: true
          field :agent_phone_number_id, -> { String }, optional: true, nullable: true
          field :whatsapp_params, -> { ::Elevenlabs::Types::BatchCallWhatsAppParams }, optional: true, nullable: true
          field :timezone, -> { String }, optional: true, nullable: true
          field :branch_id, -> { String }, optional: true, nullable: true
          field :environment, -> { String }, optional: true, nullable: true
          field :telephony_call_config, -> { ::Elevenlabs::Types::TelephonyCallConfigInput }, optional: true, nullable: false
          field :target_concurrency_limit, -> { Integer }, optional: true, nullable: true

          def validate!
            ::Elevenlabs::Validator.validate_array!(recipients, 'recipients', max_items: 10_000)
            ::Elevenlabs::Validator.validate_integer!(target_concurrency_limit, 'target_concurrency_limit', min: 1)
          end

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
