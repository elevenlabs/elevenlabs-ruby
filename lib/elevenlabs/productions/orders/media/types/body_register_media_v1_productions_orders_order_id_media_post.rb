# frozen_string_literal: true

module Elevenlabs
  module Productions
    module Orders
      module Media
        module Types
          class BodyRegisterMediaV1ProductionsOrdersOrderIDMediaPost < ::Elevenlabs::Internal::Types::Model
            field :declared_language, -> { String }, optional: false, nullable: false
            field :media, -> { String }, optional: true, nullable: true
            field :media_url, -> { String }, optional: true, nullable: true
            field :media_url_filename, -> { String }, optional: true, nullable: true
            field :media_url_content_type, -> { String }, optional: true, nullable: true

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
    end
  end
end
