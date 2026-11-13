# frozen_string_literal: true

module Elevenlabs
  module Types
    class SpeechEngineSummaryResponse < ::Elevenlabs::Internal::Types::Model
      field :speech_engine_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :voice_id, -> { String }, optional: false, nullable: false
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: false, nullable: false

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
