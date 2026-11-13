# frozen_string_literal: true

module Elevenlabs
  module Types
    class EnvironmentVariableResponse < ::Elevenlabs::Internal::Types::Model
      field :label, -> { String }, optional: false, nullable: false
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :created_by_user_id, -> { String }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::EnvironmentVariableResponseType }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :workspace_id, -> { String }, optional: false, nullable: false
      field :values, -> { ::Elevenlabs::Types::EnvironmentVariableResponseValues }, optional: false, nullable: false

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
