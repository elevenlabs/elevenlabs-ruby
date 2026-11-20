# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Receptionists
      module TransferRules
        module Types
          class ReceptionCreateTransferRuleRequest < ::Elevenlabs::Internal::Types::Model
            field :label, -> { String }, optional: false, nullable: false
            field :phone_number, -> { String }, optional: false, nullable: false
            field :condition, -> { String }, optional: false, nullable: false
            field :post_dial_digits, -> { String }, optional: true, nullable: true

            def validate!
              ::Elevenlabs::Validator.validate_string!(post_dial_digits, 'post_dial_digits', min_length: 1, max_length: 50, pattern: /^[0-9*#wW]*$/)
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
end
