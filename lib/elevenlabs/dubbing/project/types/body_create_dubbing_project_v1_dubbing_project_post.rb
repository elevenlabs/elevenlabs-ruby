# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Types
        class BodyCreateDubbingProjectV1DubbingProjectPost < ::Elevenlabs::Internal::Types::Model
          field :file, -> { String }, optional: true, nullable: true
          field :source_url, -> { String }, optional: true, nullable: true
          field :reference, -> { String }, optional: true, nullable: true
          field :source_language, -> { String }, optional: true, nullable: true
          field :model_id, -> { ::Elevenlabs::Dubbing::Project::Types::BodyCreateDubbingProjectV1DubbingProjectPostModelID }, optional: true, nullable: true
          field :keyterms, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
          field :webhook_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
          field :target_language, -> { String }, optional: true, nullable: true
          field :transcript, -> { String }, optional: true, nullable: true

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
