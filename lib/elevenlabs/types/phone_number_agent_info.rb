# frozen_string_literal: true

module Elevenlabs
  module Types
    class PhoneNumberAgentInfo < ::Elevenlabs::Internal::Types::Model
      field :agent_id, -> { String }, optional: false, nullable: false
      field :agent_name, -> { String }, optional: false, nullable: false
      field :environment, -> { String }, optional: true, nullable: true
      field :branch_id, -> { String }, optional: true, nullable: true

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
