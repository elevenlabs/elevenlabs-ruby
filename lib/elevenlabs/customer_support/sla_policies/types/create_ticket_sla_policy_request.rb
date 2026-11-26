# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module SLAPolicies
      module Types
        class CreateTicketSLAPolicyRequest < ::Elevenlabs::Internal::Types::Model
          field :name, -> { String }, optional: false, nullable: false
          field :description, -> { String }, optional: true, nullable: true
          field :targets, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketSLAPolicyTargetInput] }, optional: false, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 1, max_length: 120)
            ::Elevenlabs::Validator.validate_string!(description, 'description', max_length: 1000)
            ::Elevenlabs::Validator.validate_array!(targets, 'targets', min_items: 1)
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
