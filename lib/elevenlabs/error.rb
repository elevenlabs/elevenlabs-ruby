# frozen_string_literal: true

module Elevenlabs
  class Error < StandardError; end

  class ValidationError < Error
    attr_reader :field, :validation_message

    def initialize(field, message)
      @field              = field
      @validation_message = message
      super("Validation failed for #{field}: #{message}")
    end
  end
end
