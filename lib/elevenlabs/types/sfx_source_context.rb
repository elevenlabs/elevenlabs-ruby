# frozen_string_literal: true

module Elevenlabs
  module Types
    class SfxSourceContext < ::Elevenlabs::Internal::Types::Model
      field :source_type, -> { ::Elevenlabs::Types::SfxSourceContextSourceType }, optional: true, nullable: false
      field :sound_generation_history_item_id, -> { String }, optional: true, nullable: true
      field :text, -> { String }, optional: true, nullable: true
      field :generation_config, -> { Object }, optional: true, nullable: true

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
