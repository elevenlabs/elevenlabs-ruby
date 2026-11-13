# frozen_string_literal: true

module Elevenlabs
  module Types
    class WhatsAppOpeningMessage < ::Elevenlabs::Internal::Types::Model
      field :template_name, -> { String }, optional: false, nullable: false
      field :wamid, -> { String }, optional: true, nullable: true
      field :sent_at_unix, -> { Integer }, optional: false, nullable: false
      field :delivered_at_unix, -> { Integer }, optional: true, nullable: true
      field :read_at_unix, -> { Integer }, optional: true, nullable: true
      field :replied_at_unix, -> { Integer }, optional: true, nullable: true
      field :failed_at_unix, -> { Integer }, optional: true, nullable: true
      field :error_code, -> { String }, optional: true, nullable: true
      field :pricing_category, -> { String }, optional: true, nullable: true
      field :billable, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

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
