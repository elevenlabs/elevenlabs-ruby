# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetAgentTopicsResponseModel < ::Elevenlabs::Internal::Types::Model
      field :topics, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AgentTopicResponseModel] }, optional: false, nullable: false
      field :window_start_unix_secs, -> { Integer }, optional: false, nullable: false
      field :window_end_unix_secs, -> { Integer }, optional: false, nullable: false
      field :aggregated_run_count, -> { Integer }, optional: true, nullable: false
      field :has_more, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :next_cursor, -> { String }, optional: true, nullable: true

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
