# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Receptionists
      module Procedures
        module Types
          class ReceptionCreateProcedureRequest < ::Elevenlabs::Internal::Types::Model
            field :name, -> { String }, optional: false, nullable: false
            field :trigger, -> { String }, optional: false, nullable: false
            field :body, -> { String }, optional: true, nullable: false

            def validate!
              ::Elevenlabs::Validator.validate_string!(body, 'body', max_length: 40_000)
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
