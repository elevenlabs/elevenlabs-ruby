# frozen_string_literal: true

module Elevenlabs
  module Types
    module AgentTransferOp
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::AgentTransferOpPop }, key: 'pop'
      member -> { ::Elevenlabs::Types::AgentTransferOpPush }, key: 'push'
      member -> { ::Elevenlabs::Types::AgentTransferOpReplace }, key: 'replace'

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
