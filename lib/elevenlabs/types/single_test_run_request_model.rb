# frozen_string_literal: true

module Elevenlabs
  module Types
    class SingleTestRunRequestModel < ::Elevenlabs::Internal::Types::Model
      field :test_id, -> { String }, optional: false, nullable: false
      field :workflow_node_id, -> { String }, optional: true, nullable: true
      field :root_folder_id, -> { String }, optional: true, nullable: true
      field :root_folder_name, -> { String }, optional: true, nullable: true

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
