# frozen_string_literal: true

module Elevenlabs
  module Types
    class Render < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :version, -> { Integer }, optional: false, nullable: false
      field :language, -> { String }, optional: false, nullable: true
      field :type, -> { ::Elevenlabs::Types::RenderType }, optional: false, nullable: false
      field :media_ref, -> { ::Elevenlabs::Types::DubbingMediaReference }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::RenderStatus }, optional: false, nullable: false

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
