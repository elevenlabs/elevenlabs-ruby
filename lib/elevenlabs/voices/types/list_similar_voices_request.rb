# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Types
      class ListSimilarVoicesRequest < ::Elevenlabs::Internal::Types::Model
        field :audio_file, -> { String }, optional: true, nullable: false
        field :similarity_threshold, -> { Float }, optional: true, nullable: true
        field :top_k, -> { Integer }, optional: true, nullable: true

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
end
