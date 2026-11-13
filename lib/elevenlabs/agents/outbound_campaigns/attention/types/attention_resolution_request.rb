# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Attention
        module Types
          class AttentionResolutionRequest < ::Elevenlabs::Internal::Types::Model
            field :resolution, -> { String }, optional: false, nullable: false

            def validate!
              ::Elevenlabs::Validator.validate_string!(resolution, 'resolution', min_length: 1, max_length: 1000)
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
    end
  end
end
