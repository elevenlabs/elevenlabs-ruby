# frozen_string_literal: true

module Elevenlabs
  module PronunciationDictionaries
    module Rules
      module Types
        class PronunciationDictionary < ::Elevenlabs::Internal::Types::Model
          field :rules, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::PronunciationDictionaries::Rules::Types::PronunciationDictionaryRule] }, optional: false, nullable: false

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
