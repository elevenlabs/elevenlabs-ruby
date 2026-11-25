# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Language
        module Transcript
          module Types
            class DubbingTargetSegmentUpdateRequest < ::Elevenlabs::Internal::Types::Model
              field :project_id, -> { String }, optional: false, nullable: false
              field :language_id, -> { String }, optional: false, nullable: false
              field :segment_id, -> { String }, optional: false, nullable: false
              field :translation, -> { String }, optional: true, nullable: true

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
end
