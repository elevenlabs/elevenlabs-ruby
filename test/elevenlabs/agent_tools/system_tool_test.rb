# frozen_string_literal: true

require_relative 'support'

module Elevenlabs
  module AgentTools
    class SystemToolTest < Minitest::Test
      include Support

      SIP = Destination.sip('sip:sales@pbx.example.com')
      SIP_VARIABLE = Destination.sip_variable('partner_sip')

      def test_shares_the_workflow_builders_destination
        assert_same ::Elevenlabs::AgentWorkflows::Destination, Destination
      end

      def test_build_config_is_an_entry_prompt_built_in_tools_accepts
        built_in = ::Elevenlabs::Types::BuiltInToolsInput.new(end_call: SystemTool.end_call.build_config)

        assert_equal({ 'end_call' => { 'type' => 'system', 'name' => 'end_call', 'params' => { 'system_tool_type' => 'end_call' } } },
                     built_in.to_h)
      end

      def test_build_config_is_the_generated_system_config
        assert_instance_of ::Elevenlabs::Types::SystemToolConfigInput, SystemTool.end_call.build_config
      end

      def test_constructor_options_become_params
        assert_equal({ 'only_at_conversation_start' => true, 'system_tool_type' => 'language_detection' },
                     SystemTool.language_detection(only_at_conversation_start: true).to_json['params'])
      end

      def test_rejects_transfer_on_a_tool_that_does_not_transfer
        assert_equal(['invalid_option'],
                     codes_of { SystemTool.end_call.transfer('Caller asks', Destination.phone('+15551234567')).build })
      end

      def test_transfers_to_a_sip_uri_with_a_sip_refer
        [SIP, SIP_VARIABLE].each do |destination|
          SystemTool.transfer_to_number.transfer('Caller wants sales', destination, transfer_type: 'sip_refer').build
        end
      end

      def test_rejects_a_sip_uri_without_a_sip_refer
        codes = [SIP, SIP_VARIABLE].map do |destination|
          codes_of { SystemTool.transfer_to_number.transfer('Caller wants sales', destination).build }
        end

        assert_equal [%w[invalid_destination no_transfers]] * 2, codes
      end

      def test_rejects_options_of_the_other_transfer_kind
        issues = codes_and_paths_of do
          SystemTool.transfer_to_agent
                    .transfer('Caller wants sales', Destination.agent('agent_sales'), transfer_type: 'conference')
                    .build
        end

        assert_equal [%w[invalid_option transfer_type]], issues
      end

      def test_rejects_a_phone_destination_on_transfer_to_agent
        assert_equal(%w[invalid_destination no_transfers],
                     codes_of { SystemTool.transfer_to_agent.transfer('Caller asks', Destination.phone('+1555')).build })
      end

      def test_rejects_webhook_options
        assert_equal(['invalid_option'], codes_of { SystemTool.end_call.options(execution_mode: 'async').build })
      end
    end
  end
end
