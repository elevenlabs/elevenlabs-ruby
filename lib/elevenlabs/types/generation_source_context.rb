# frozen_string_literal: true

module Elevenlabs
  module Types
    class GenerationSourceContext < ::Elevenlabs::Internal::Types::Model
      field :source_type, -> { ::Elevenlabs::Types::GenerationSourceContextSourceType }, optional: true, nullable: false
      field :generation_id, -> { String }, optional: false, nullable: false
      field :prompt, -> { String }, optional: true, nullable: true
      field :model_id, -> { String }, optional: false, nullable: false
      field :model_provider, -> { String }, optional: true, nullable: true
      field :generation_session_id, -> { String }, optional: true, nullable: true
      field :session_iteration_id, -> { String }, optional: true, nullable: true
      field :model_parameters, -> { Object }, optional: true, nullable: true
      field :extend_video, -> { ::Elevenlabs::Types::ReferenceVideo }, optional: true, nullable: true

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
