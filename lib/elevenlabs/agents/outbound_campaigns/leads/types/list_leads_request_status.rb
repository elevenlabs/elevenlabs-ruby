# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Leads
        module Types
          module ListLeadsRequestStatus
            extend ::Elevenlabs::Internal::Types::Enum

            IN_PROGRESS = :in_progress
            FINISHED = :finished

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
