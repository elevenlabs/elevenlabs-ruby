# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetToolDependentAgentsResponseModel < ::Elevenlabs::Internal::Types::Model
      field :agents, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::GetToolDependentAgentsResponseModelAgentsItem] }, optional: false, nullable: false
      field :branches, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DependentBranchInfo] }, optional: true, nullable: false
      field :next_cursor, -> { String }, optional: true, nullable: true
      field :has_more, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
