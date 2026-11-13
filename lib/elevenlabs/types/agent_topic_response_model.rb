# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentTopicResponseModel < ::Elevenlabs::Internal::Types::Model
      field :topic_id, -> { String }, optional: false, nullable: false
      field :label, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :conversation_count, -> { Integer }, optional: false, nullable: false
      field :parent_topic_id, -> { String }, optional: true, nullable: true
      field :x2d, -> { Float }, optional: true, nullable: true, api_name: 'x_2d'
      field :y2d, -> { Float }, optional: true, nullable: true, api_name: 'y_2d'
      field :metrics, -> { ::Elevenlabs::Types::TopicMetricsAggregate }, optional: true, nullable: true
      field :success_rate, -> { Float }, optional: true, nullable: true

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
