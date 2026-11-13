# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentVersionMetadata < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :branch_id, -> { String }, optional: false, nullable: false
      field :version_description, -> { String }, optional: false, nullable: false
      field :seq_no_in_branch, -> { Integer }, optional: false, nullable: false
      field :time_committed_secs, -> { Integer }, optional: false, nullable: false
      field :parents, -> { ::Elevenlabs::Types::AgentVersionParents }, optional: false, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: true, nullable: false
      field :merged_authors, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ResourceAccessInfo] }, optional: true, nullable: true

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
