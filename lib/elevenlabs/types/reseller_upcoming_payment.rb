# frozen_string_literal: true

module Elevenlabs
  module Types
    class ResellerUpcomingPayment < ::Elevenlabs::Internal::Types::Model
      field :workspace_id, -> { String }, optional: false, nullable: false
      field :workspace_name, -> { String }, optional: false, nullable: false
      field :subscription, -> { ::Elevenlabs::Types::ResellerWorkspaceSubscription }, optional: false, nullable: false
      field :plan_usd, -> { Float }, optional: false, nullable: false
      field :overage_so_far_usd, -> { Float }, optional: false, nullable: false

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
