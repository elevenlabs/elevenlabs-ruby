# frozen_string_literal: true

module Elevenlabs
  module Types
    module TransferToAgentToolResultSuccessModelOutputBranchInfo
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :branch_reason
      member -> { ::Elevenlabs::Types::TransferBranchInfoConfigured }, key: 'configured'
      member -> { ::Elevenlabs::Types::TransferBranchInfoDefaultingToMain }, key: 'defaulting_to_main'
      member -> { ::Elevenlabs::Types::TransferBranchInfoTrafficSplit }, key: 'traffic_split'

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
