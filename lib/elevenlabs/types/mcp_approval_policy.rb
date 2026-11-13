# frozen_string_literal: true

module Elevenlabs
  module Types
    module McpApprovalPolicy
      extend ::Elevenlabs::Internal::Types::Enum

      AUTO_APPROVE_ALL = :auto_approve_all
      REQUIRE_APPROVAL_ALL = :require_approval_all
      REQUIRE_APPROVAL_PER_TOOL = :require_approval_per_tool

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
