# frozen_string_literal: true

module Elevenlabs
  module Types
    module BranchProtectionStatus
      extend ::Elevenlabs::Internal::Types::Enum

      WRITER_PERMS_REQUIRED = :writer_perms_required
      ADMIN_PERMS_REQUIRED = :admin_perms_required

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
