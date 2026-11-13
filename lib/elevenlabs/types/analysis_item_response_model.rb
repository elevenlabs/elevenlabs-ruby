# frozen_string_literal: true

module Elevenlabs
  module Types
    class AnalysisItemResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :definition, -> { ::Elevenlabs::Types::AnalysisItemResponseModelDefinition }, optional: false, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: false, nullable: false
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :current_version_id, -> { String }, optional: false, nullable: false
      field :legacy_source_id, -> { String }, optional: true, nullable: true

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
