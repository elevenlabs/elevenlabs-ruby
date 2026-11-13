# frozen_string_literal: true

module Elevenlabs
  module Types
    class MediaGenerationCompletedResponse < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::MediaGenerationCompletedResponseStatus }, optional: false, nullable: false
      field :content_url, -> { String }, optional: false, nullable: false
      field :content_mime_type, -> { String }, optional: false, nullable: false

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
