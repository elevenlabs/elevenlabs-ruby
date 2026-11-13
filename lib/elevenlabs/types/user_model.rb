# frozen_string_literal: true

module Elevenlabs
  module Types
    class UserModel < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: true, nullable: true
      field :uid, -> { String }, optional: true, nullable: true
      field :type_id, -> { ::Elevenlabs::Types::UserTypeID }, optional: true, nullable: false
      field :type, -> { String }, optional: true, nullable: true
      field :email_addr, -> { String }, optional: true, nullable: true
      field :full_name, -> { String }, optional: true, nullable: true
      field :domain, -> { String }, optional: true, nullable: true

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
