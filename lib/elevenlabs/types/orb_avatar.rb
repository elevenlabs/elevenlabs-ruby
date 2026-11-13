# frozen_string_literal: true

module Elevenlabs
  module Types
    class OrbAvatar < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::OrbAvatarType }, optional: true, nullable: false
      field :color1, -> { String }, optional: true, nullable: false, api_name: 'color_1'
      field :color2, -> { String }, optional: true, nullable: false, api_name: 'color_2'

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
