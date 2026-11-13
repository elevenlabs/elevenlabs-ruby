# frozen_string_literal: true

module Elevenlabs
  module Types
    module TemplateImageOutputFailureReason
      extend ::Elevenlabs::Internal::Types::Enum

      TIMEOUT = :timeout
      MODEL_ERROR = :model_error
      MODERATED = :moderated
      INVALID_PARAMETERS = :invalid_parameters
      DEPENDENCY_FAILED = :dependency_failed
      CHARGING_FAILED = :charging_failed
      INTERNAL_ERROR = :internal_error

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
