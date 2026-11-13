# frozen_string_literal: true

module Elevenlabs
  module Types
    class TemplateSummary < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: true
      field :versions, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TemplateVersion] }, optional: false, nullable: false
      field :has_more_versions, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
