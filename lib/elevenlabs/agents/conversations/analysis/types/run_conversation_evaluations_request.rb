# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Analysis
        module Types
          class RunConversationEvaluationsRequest < ::Elevenlabs::Internal::Types::Model
            field :evaluation_id, -> { String }, optional: false, nullable: false
            field :scope, -> { ::Elevenlabs::Types::AnalysisScope }, optional: true, nullable: false
            field :evaluated_agent_id, -> { String }, optional: true, nullable: true
            field :evaluated_branch_id, -> { String }, optional: true, nullable: true

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
