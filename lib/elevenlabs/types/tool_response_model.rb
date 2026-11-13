# frozen_string_literal: true

module Elevenlabs
  module Types
    class ToolResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :tool_config, -> { ::Elevenlabs::Types::ToolResponseModelToolConfig }, optional: false, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: false, nullable: false
      field :usage_stats, -> { ::Elevenlabs::Types::ToolUsageStatsResponseModel }, optional: false, nullable: false
      field :response_mocks, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ToolResponseMockConfigOutput] }, optional: true, nullable: true

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
