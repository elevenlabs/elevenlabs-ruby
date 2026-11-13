# frozen_string_literal: true

module Elevenlabs
  module Types
    class DependentBranchInfo < ::Elevenlabs::Internal::Types::Model
      field :agent_id, -> { String }, optional: false, nullable: false
      field :agent_name, -> { String }, optional: false, nullable: false
      field :branch_id, -> { String }, optional: false, nullable: false
      field :branch_name, -> { String }, optional: false, nullable: false
      field :is_main, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
