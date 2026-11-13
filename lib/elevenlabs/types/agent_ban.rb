# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentBan < ::Elevenlabs::Internal::Types::Model
      field :at_unix, -> { Integer }, optional: false, nullable: false
      field :reason, -> { String }, optional: true, nullable: true
      field :reason_type, -> { ::Elevenlabs::Types::BanReasonType }, optional: false, nullable: false

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
