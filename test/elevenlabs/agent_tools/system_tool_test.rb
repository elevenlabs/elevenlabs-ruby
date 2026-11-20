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

      TRANSFER_RULE = {
        'condition' => 'Caller asks for the front desk',
        'provider_configs' => [{
          'type' => 'twilio',
          'config' => {
            'type' => 'twilio_cold_blind_transfer',
            'transfer_destination' => { 'type' => 'phone', 'destination' => '+15551234567' },
          },
        }],
      }.freeze

      def loaded_transfer(system_tool_type)
        Tool.from_json({
                         'type' => 'system',
                         'name' => system_tool_type,
                         'params' => { 'system_tool_type' => system_tool_type, 'transfers' => [],
                                       'transfer_rules' => [TRANSFER_RULE] },
                       })
      end

      def test_transfer_rules_do_not_satisfy_an_agent_transfer
        assert_equal(['no_transfers'], codes_of { loaded_transfer('transfer_to_agent').build })
      end

      def test_sends_loaded_transfer_rules_in_the_built_request
        sent = JSON.parse(::Elevenlabs::Types::ToolRequestModel.dump(loaded_transfer('transfer_to_number').build))

        assert_equal [TRANSFER_RULE], sent['tool_config']['params']['transfer_rules']
      end
    end
  end
end
