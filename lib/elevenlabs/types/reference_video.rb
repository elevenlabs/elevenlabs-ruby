# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReferenceVideo < ::Elevenlabs::Internal::Types::Model
      field :generation_id, -> { String }, optional: true, nullable: true
      field :content_asset_id, -> { String }, optional: true, nullable: true
      field :template_node_id, -> { String }, optional: true, nullable: true
      field :studio_clip, -> { ::Elevenlabs::Types::StudioClipLocator }, optional: true, nullable: true

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
