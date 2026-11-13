# frozen_string_literal: true

module Elevenlabs
  module Types
    class ActorModel < ::Elevenlabs::Internal::Types::Model
      field :user, -> { ::Elevenlabs::Types::UserModel }, optional: false, nullable: false
      field :app_name, -> { String }, optional: true, nullable: true
      field :app_uid, -> { String }, optional: true, nullable: true
      field :session, -> { Object }, optional: true, nullable: true

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
