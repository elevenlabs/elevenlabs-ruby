# frozen_string_literal: true

module Elevenlabs
  module Types
    class PronunciationDictionaryVersionResponseModel < ::Elevenlabs::Internal::Types::Model
      field :version_id, -> { String }, optional: false, nullable: false
      field :version_rules_num, -> { Integer }, optional: false, nullable: false
      field :pronunciation_dictionary_id, -> { String }, optional: false, nullable: false
      field :dictionary_name, -> { String }, optional: false, nullable: false
      field :version_name, -> { String }, optional: false, nullable: false
      field :permission_on_resource, -> { ::Elevenlabs::Types::PronunciationDictionaryVersionResponseModelPermissionOnResource }, optional: false, nullable: true
      field :created_by, -> { String }, optional: false, nullable: false
      field :creation_time_unix, -> { Integer }, optional: false, nullable: false
      field :archived_time_unix, -> { Integer }, optional: true, nullable: true

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
