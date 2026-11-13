# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Types
      module ObjectJSONSchemaPropertyOutputPropertiesValue
        extend ::Elevenlabs::Internal::Types::Union

        member -> { ::Elevenlabs::Types::LiteralJSONSchemaProperty }
        member -> { ::Elevenlabs::Types::ObjectJSONSchemaPropertyOutput }
        member -> { ::Elevenlabs::Types::ArrayJSONSchemaPropertyOutput }

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
