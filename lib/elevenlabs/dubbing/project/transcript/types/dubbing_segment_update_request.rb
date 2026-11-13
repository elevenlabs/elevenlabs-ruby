# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Transcript
        module Types
          class DubbingSegmentUpdateRequest < ::Elevenlabs::Internal::Types::Model
            field :text, -> { String }, optional: true, nullable: true
            field :speaker_id, -> { String }, optional: true, nullable: true
            field :start_s, -> { Float }, optional: true, nullable: true
            field :end_s, -> { Float }, optional: true, nullable: true

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
  end
end
