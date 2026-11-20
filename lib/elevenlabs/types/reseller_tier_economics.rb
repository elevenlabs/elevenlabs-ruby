# frozen_string_literal: true

module Elevenlabs
  module Types
    class ResellerTierEconomics < ::Elevenlabs::Internal::Types::Model
      field :monthly_price_usd, -> { Float }, optional: false, nullable: false
      field :annual_price_usd, -> { Float }, optional: false, nullable: true
      field :included_minutes_per_month, -> { Float }, optional: false, nullable: false
      field :overage_price_per_minute_usd, -> { Float }, optional: false, nullable: true
      field :max_phone_numbers, -> { Integer }, optional: false, nullable: false
      field :concurrent_calls, -> { Integer }, optional: false, nullable: false
      field :max_active_locations, -> { Integer }, optional: false, nullable: false
      field :max_customer_facing_agents, -> { Integer }, optional: false, nullable: false
      field :max_team_members, -> { Integer }, optional: false, nullable: false
      field :assistant_daily_messages, -> { Integer }, optional: false, nullable: false

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
