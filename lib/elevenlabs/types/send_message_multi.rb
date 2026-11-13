# frozen_string_literal: true

module Elevenlabs
  module Types
    module SendMessageMulti
      extend ::Elevenlabs::Internal::Types::Union

      member -> { ::Elevenlabs::Types::InitializeConnectionMulti }
      member -> { ::Elevenlabs::Types::InitialiseContext }
      member -> { ::Elevenlabs::Types::SendTextMulti }
      member -> { ::Elevenlabs::Types::FlushContext }
      member -> { ::Elevenlabs::Types::CloseContext }
      member -> { ::Elevenlabs::Types::CloseSocket }
      member -> { ::Elevenlabs::Types::KeepContextAlive }

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
