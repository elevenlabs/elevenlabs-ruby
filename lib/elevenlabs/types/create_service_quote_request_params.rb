# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreateServiceQuoteRequestParams < ::Elevenlabs::Internal::Types::Model
      field :smb_tool_type, -> { ::Elevenlabs::Types::CreateServiceQuoteRequestParamsSmbToolType }, optional: true, nullable: false

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
