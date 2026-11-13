# frozen_string_literal: true

module Elevenlabs
  module Types
    class MergeProposalComment < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :user_id, -> { String }, optional: false, nullable: false
      field :body, -> { String }, optional: false, nullable: false
      field :created_at, -> { Integer }, optional: false, nullable: false

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
