# frozen_string_literal: true

module Elevenlabs
  module Types
    class OpenAimcpTool < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::OpenAimcpToolType }, optional: true, nullable: false
      field :server_label, -> { String }, optional: false, nullable: false
      field :server_url, -> { String }, optional: false, nullable: false
      field :authorization, -> { String }, optional: true, nullable: true
      field :allowed_tools, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :require_approval, -> { ::Elevenlabs::Types::OpenAimcpToolRequireApproval }, optional: true, nullable: false

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
