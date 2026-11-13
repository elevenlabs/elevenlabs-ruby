# frozen_string_literal: true

module Elevenlabs
  module Types
    class AddPronunciationDictionaryResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :created_by, -> { String }, optional: false, nullable: false
      field :creation_time_unix, -> { Integer }, optional: false, nullable: false
      field :version_id, -> { String }, optional: false, nullable: false
      field :version_rules_num, -> { Integer }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: true
      field :permission_on_resource, -> { ::Elevenlabs::Types::AddPronunciationDictionaryResponseModelPermissionOnResource }, optional: false, nullable: true

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
