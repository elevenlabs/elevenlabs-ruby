# frozen_string_literal: true

module Elevenlabs
  module Types
    class TicketRequesterBySlackRequest < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::TicketRequesterBySlackRequestType }, optional: true, nullable: false
      field :team_id, -> { String }, optional: false, nullable: false
      field :user_id, -> { String }, optional: false, nullable: false
      field :full_name, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(team_id, 'team_id', min_length: 1)
        ::Elevenlabs::Validator.validate_string!(user_id, 'user_id', min_length: 1)
        ::Elevenlabs::Validator.validate_string!(full_name, 'full_name', min_length: 1)
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
