# frozen_string_literal: true

module Elevenlabs
  module Reception
    module PhoneNumbers
      module Types
        class CreatePhoneAssignmentRequest < ::Elevenlabs::Internal::Types::Model
          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
          field :customer_facing_agent_id, -> { String }, optional: false, nullable: false
          field :area_codes, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
          field :number_type, -> { ::Elevenlabs::Types::ApplicationNumberType }, optional: true, nullable: false
          field :idempotency_key, -> { String }, optional: true, nullable: true

          def validate!
            ::Elevenlabs::Validator.validate_string!(idempotency_key, 'idempotency_key', max_length: 255)
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
