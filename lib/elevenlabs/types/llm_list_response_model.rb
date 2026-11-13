# frozen_string_literal: true

module Elevenlabs
  module Types
    class LlmListResponseModel < ::Elevenlabs::Internal::Types::Model
      field :llms, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::LlmInfoModel] }, optional: false, nullable: false
      field :default_deprecation_config, -> { ::Elevenlabs::Types::LlmDeprecationConfigModel }, optional: false, nullable: false

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
