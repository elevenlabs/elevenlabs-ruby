# frozen_string_literal: true

module Elevenlabs
  module Types
    class AvatarContextResponseModel < ::Elevenlabs::Internal::Types::Model
      field :avatar_id, -> { String }, optional: true, nullable: true
      field :avatar_style_id, -> { String }, optional: true, nullable: true
      field :avatar_name, -> { String }, optional: true, nullable: true
      field :avatar_style_name, -> { String }, optional: true, nullable: true

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
