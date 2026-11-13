# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetPronunciationDictionaryWithRulesResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :latest_version_id, -> { String }, optional: false, nullable: false
      field :latest_version_rules_num, -> { Integer }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :permission_on_resource, -> { ::Elevenlabs::Types::GetPronunciationDictionaryWithRulesResponseModelPermissionOnResource }, optional: false, nullable: true
      field :created_by, -> { String }, optional: false, nullable: false
      field :creation_time_unix, -> { Integer }, optional: false, nullable: false
      field :archived_time_unix, -> { Integer }, optional: true, nullable: true
      field :description, -> { String }, optional: true, nullable: true
      field :rules, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::GetPronunciationDictionaryWithRulesResponseModelRulesItem] }, optional: false, nullable: false

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
