# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Config
        module Types
          class ReplaceWorkspaceConfigRequest < ::Elevenlabs::Internal::Types::Model
            field :expected_version, -> { Integer }, optional: true, nullable: true
            field :config, -> { ::Elevenlabs::Types::CampaignConfigInput }, optional: false, nullable: false

            def validate!
              ::Elevenlabs::Validator.validate_integer!(expected_version, 'expected_version', min: 1)
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
