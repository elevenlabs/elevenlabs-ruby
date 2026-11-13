# frozen_string_literal: true

module Elevenlabs
  module Types
    class TransferToAgentToolResultErrorModel < ::Elevenlabs::Internal::Types::Model
      field :result_type, -> { ::Elevenlabs::Types::TransferToAgentToolResultErrorModelResultType }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::TransferToAgentToolResultErrorModelStatus }, optional: true, nullable: false
      field :from_agent, -> { String }, optional: false, nullable: false
      field :error, -> { String }, optional: false, nullable: false

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
