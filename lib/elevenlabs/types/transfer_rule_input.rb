# frozen_string_literal: true

module Elevenlabs
  module Types
    class TransferRuleInput < ::Elevenlabs::Internal::Types::Model
      field :provider_configs, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TransferRuleInputProviderConfigsItem] }, optional: false, nullable: false
      field :condition, -> { String }, optional: false, nullable: false

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
