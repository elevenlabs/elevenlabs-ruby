# frozen_string_literal: true

module Elevenlabs
  module Types
    class StudioClipLocator < ::Elevenlabs::Internal::Types::Model
      field :project_id, -> { String }, optional: false, nullable: false
      field :chapter_id, -> { String }, optional: false, nullable: false
      field :clip_type, -> { ::Elevenlabs::Types::StudioClipLocatorClipType }, optional: false, nullable: false
      field :clip_id, -> { String }, optional: false, nullable: false
      field :block_id, -> { String }, optional: true, nullable: true
      field :preview_url, -> { String }, optional: true, nullable: true

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
