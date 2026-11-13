# frozen_string_literal: true

module Elevenlabs
  module Types
    class WhatsAppCallPermissionRequest < ::Elevenlabs::Internal::Types::Model
      field :state, -> { ::Elevenlabs::Types::WhatsAppCallPermissionRequestState }, optional: false, nullable: false
      field :requested_at_unix, -> { Integer }, optional: true, nullable: true
      field :responded_at_unix, -> { Integer }, optional: true, nullable: true
      field :permanent, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :granted_by_user_call, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

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
