# frozen_string_literal: true

require 'minitest/autorun'
require 'elevenlabs'
require 'elevenlabs/agent_tools'

module Elevenlabs
  module AgentTools
    # Helpers shared by the tool builder's unit tests.
    module Support
      def get_order
        Tool.webhook('get_order', 'Look up an order')
            .get('https://api.example.com/orders/{order_id}')
            .path_param('order_id', Schema.string.describe('The order number'))
      end

      # The issues build() raises, or a failure if it doesn't raise.
      def issues_of
        yield

        flunk 'expected a ToolValidationError'
      rescue ToolValidationError => e
        e.issues
      end

      def codes_of(&)
        issues_of(&).map(&:code)
      end

      def codes_and_paths_of(&)
        issues_of(&).map { |issue| [issue.code, issue.path] }
      end
    end
  end
end
