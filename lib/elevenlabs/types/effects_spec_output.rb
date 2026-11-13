# frozen_string_literal: true

module Elevenlabs
  module Types
    class EffectsSpecOutput < ::Elevenlabs::Internal::Types::Model
      field :filter_preset_id, -> { String }, optional: false, nullable: true
      field :distance, -> { Float }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: true
      field :background_noise_id, -> { String }, optional: false, nullable: true
      field :send_level, -> { Float }, optional: false, nullable: false
      field :pan, -> { Float }, optional: false, nullable: false

      def validate!
        Validator.validate_number!(distance, 'distance', min: 0, max: 1)
        Validator.validate_number!(send_level, 'send_level', min: 0, max: 1)
        Validator.validate_number!(pan, 'pan', min: -1, max: 1)
      end

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
