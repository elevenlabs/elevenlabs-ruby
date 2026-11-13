# frozen_string_literal: true

module Elevenlabs
  module Types
    class ProjectVoiceResponseModel < ::Elevenlabs::Internal::Types::Model
      field :project_voice_ref_id, -> { String }, optional: false, nullable: false
      field :voice_id, -> { String }, optional: false, nullable: false
      field :alias_, -> { String }, optional: false, nullable: false, api_name: 'alias'
      field :stability, -> { Float }, optional: false, nullable: false
      field :similarity_boost, -> { Float }, optional: false, nullable: false
      field :style, -> { Float }, optional: false, nullable: false
      field :is_pinned, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :use_speaker_boost, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :volume_gain, -> { Float }, optional: false, nullable: false
      field :speed, -> { Float }, optional: false, nullable: false

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
