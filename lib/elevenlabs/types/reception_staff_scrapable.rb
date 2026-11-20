# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionStaffScrapable < ::Elevenlabs::Internal::Types::Model
      field :groups, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionGroupMembership] }, optional: true, nullable: false
      field :ungrouped_rank, -> { Integer }, optional: true, nullable: true
      field :name, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(groups, 'groups', max_items: 20)
        ::Elevenlabs::Validator.validate_integer!(ungrouped_rank, 'ungrouped_rank', min: 0)
      end

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
