# frozen_string_literal: true

module Elevenlabs
  module Types
    class TemplateVersion < ::Elevenlabs::Internal::Types::Model
      field :version_id, -> { String }, optional: false, nullable: false
      field :published_at_unix, -> { Integer }, optional: false, nullable: false
      field :is_latest, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :inputs, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TemplatePort] }, optional: false, nullable: false
      field :outputs, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TemplatePort] }, optional: false, nullable: false

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
