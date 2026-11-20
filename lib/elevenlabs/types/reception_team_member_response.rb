# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionTeamMemberResponse < ::Elevenlabs::Internal::Types::Model
      field :user_id, -> { String }, optional: false, nullable: false
      field :email, -> { String }, optional: false, nullable: false
      field :first_name, -> { String }, optional: true, nullable: true
      field :is_owner, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :is_admin, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :picture_url, -> { String }, optional: true, nullable: true
      field :is_suspended, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
