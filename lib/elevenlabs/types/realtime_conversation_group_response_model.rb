# frozen_string_literal: true

module Elevenlabs
  module Types
    class RealtimeConversationGroupResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :title, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: true
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: false, nullable: false
      field :sharing, -> { ::Elevenlabs::Types::RealtimeConversationGroupSharingSummary }, optional: false, nullable: false
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false

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
