# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentVersionParents < ::Elevenlabs::Internal::Types::Model
      field :in_branch_parent_id, -> { String }, optional: true, nullable: true
      field :out_of_branch_parent_id, -> { String }, optional: true, nullable: true
      field :merged_into_branch_id, -> { String }, optional: true, nullable: true
      field :merged_from_branch_id, -> { String }, optional: true, nullable: true
      field :merged_from_version_id, -> { String }, optional: true, nullable: true
      field :rebased_from_version_id, -> { String }, optional: true, nullable: true

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
