# frozen_string_literal: true

module Elevenlabs
  module Types
    class AudioAnalysis < ::Elevenlabs::Internal::Types::Model
      field :status, -> { ::Elevenlabs::Types::AudioAnalysisStatus }, optional: false, nullable: false
      field :data, -> { ::Elevenlabs::Types::AudioAnalysisResult }, optional: false, nullable: true
      field :updated_at_ms, -> { Integer }, optional: true, nullable: false

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
