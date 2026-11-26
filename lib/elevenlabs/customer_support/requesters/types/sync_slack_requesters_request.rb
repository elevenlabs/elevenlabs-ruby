# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module Requesters
      module Types
        class SyncSlackRequestersRequest < ::Elevenlabs::Internal::Types::Model
          field :integration_connection_id, -> { String }, optional: false, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_string!(integration_connection_id, 'integration_connection_id', min_length: 1)
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
