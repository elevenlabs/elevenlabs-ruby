# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Types
      module EditVoiceRequestLabels
        extend ::Elevenlabs::Internal::Types::Union

        member -> { ::Elevenlabs::Internal::Types::Hash[String, String] }
        member -> { String }

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
