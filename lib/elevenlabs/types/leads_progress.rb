# frozen_string_literal: true

module Elevenlabs
  module Types
    class LeadsProgress < ::Elevenlabs::Internal::Types::Model
      field :total, -> { Integer }, optional: false, nullable: false
      field :uncalled, -> { Integer }, optional: false, nullable: false
      field :leads_needing_attention, -> { Integer }, optional: false, nullable: false
      field :active, -> { Integer }, optional: false, nullable: false
      field :finished, -> { Integer }, optional: false, nullable: false
      field :finished_by_disposition, -> { ::Elevenlabs::Internal::Types::Hash[String, Integer] }, optional: false, nullable: false

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
