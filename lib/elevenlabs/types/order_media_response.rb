# frozen_string_literal: true

module Elevenlabs
  module Types
    class OrderMediaResponse < ::Elevenlabs::Internal::Types::Model
      field :media_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :content_type, -> { String }, optional: false, nullable: false
      field :language, -> { String }, optional: true, nullable: true
      field :signed_url, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(media_id, 'media_id', pattern: /^prodmedia_[a-z0-9]{26}$/)
      end

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
