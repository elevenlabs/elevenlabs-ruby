# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Summaries
      module Types
        module GetSummariesResponse2
          extend ::Elevenlabs::Internal::Types::Union

          discriminant :status
          member -> { ::Elevenlabs::Types::KnowledgeBaseSummaryBatchSuccessfulResponseModel }, key: 'success'
          member -> { ::Elevenlabs::Types::BatchFailureResponseModel }, key: 'failure'

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
