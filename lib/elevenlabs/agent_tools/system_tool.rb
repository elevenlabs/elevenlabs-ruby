# frozen_string_literal: true

require_relative 'errors'
require_relative 'tool'
require_relative 'wire'

module Elevenlabs
  module AgentTools
    # A built-in tool the agent runs itself, such as ending the call or transferring it. Its name defaults to
    # its system_tool_type, and its description is left out so the API uses its own; set either with
    # options.
    class SystemTool < Tool
      PHONE_TRANSFER_OPTIONS = %w[transfer_type custom_sip_headers sip_refer_play_dialtone uui post_dial_digits].freeze
      AGENT_TRANSFER_OPTIONS = %w[
        delay_ms transfer_message enable_transferred_agent_first_message preserve_client_tts_overrides
        preserve_voice_settings
      ].freeze
      TRANSFER_TYPES = %w[transfer_to_number transfer_to_agent].freeze
      SIP_DESTINATIONS = %w[sip_uri sip_uri_dynamic_variable].freeze

      # The API's system_tool_type, e.g. "end_call".
      attr_reader :system_tool_type

      # @api private — use the static constructors.
      def initialize(system_tool_type, config, params)
        super(config)
        @system_tool_type = system_tool_type
        @params = params
      end

      class << self
        # Lets the agent end the call.
        def end_call
          create('end_call', {})
        end

        # Lets the agent stay quiet when the user asks for a moment. +wait_timeout_secs+ is how long to
        # wait before the agent checks in; -1 waits for the user.
        def skip_turn(wait_timeout_secs: nil)
          create('skip_turn', 'wait_timeout_secs' => wait_timeout_secs)
        end

        # Lets the agent switch language. +only_at_conversation_start+ only switches during the first two
        # user turns.
        def language_detection(only_at_conversation_start: nil)
          create('language_detection', 'only_at_conversation_start' => only_at_conversation_start)
        end

        # Lets the agent play keypad tones, for phone menus. +use_out_of_band_dtmf+ sends tones as RTP events
        # (SIP trunk numbers only); +suppress_turn_after_dtmf+ keeps the agent quiet after playing tones.
        def play_keypad_touch_tone(use_out_of_band_dtmf: nil, suppress_turn_after_dtmf: nil)
          create('play_keypad_touch_tone',
                 'use_out_of_band_dtmf' => use_out_of_band_dtmf, 'suppress_turn_after_dtmf' => suppress_turn_after_dtmf)
        end

        # Lets the agent detect voicemail and leave +voicemail_message+, or hang up without one.
        def voicemail_detection(voicemail_message: nil)
          create('voicemail_detection', 'voicemail_message' => voicemail_message)
        end

        # Lets the agent search its knowledge base with +enabled_strategies+.
        def knowledge_base(enabled_strategies: nil)
          create('knowledge_base', 'enabled_strategies' => enabled_strategies)
        end

        # Lets the agent transfer the call to a phone number or SIP URI. Add destinations with transfer.
        # +enable_client_message+ plays a message to the caller while they wait.
        def transfer_to_number(enable_client_message: nil)
          create('transfer_to_number', 'enable_client_message' => enable_client_message, 'transfers' => [])
        end

        # Lets the agent hand the conversation to another agent. Add destinations with transfer.
        def transfer_to_agent
          create('transfer_to_agent', 'transfers' => [])
        end

        private

        def create(system_tool_type, params)
          new(system_tool_type, { 'name' => system_tool_type }, ToolWire.value(params.compact))
        end
      end

      def kind
        'system'
      end

      # Adds a destination to a transfer tool. +condition+ is plain text telling the LLM when to transfer
      # there. transfer_to_number takes phone and SIP Destinations (a SIP URI needs
      # transfer_type: 'sip_refer'), with the options +transfer_type+, +custom_sip_headers+,
      # +sip_refer_play_dialtone+, +uui+ and +post_dial_digits+. transfer_to_agent takes agent Destinations,
      # with +delay_ms+, +transfer_message+, +enable_transferred_agent_first_message+,
      # +preserve_client_tts_overrides+ and +preserve_voice_settings+.
      def transfer(condition, destination, transfer_type: nil, custom_sip_headers: nil, sip_refer_play_dialtone: nil,
                   uui: nil, post_dial_digits: nil, delay_ms: nil, transfer_message: nil,
                   enable_transferred_agent_first_message: nil, preserve_client_tts_overrides: nil,
                   preserve_voice_settings: nil)
        options = {
          'transfer_type' => transfer_type, 'custom_sip_headers' => custom_sip_headers,
          'sip_refer_play_dialtone' => sip_refer_play_dialtone, 'uui' => uui, 'post_dial_digits' => post_dial_digits,
          'delay_ms' => delay_ms, 'transfer_message' => transfer_message,
          'enable_transferred_agent_first_message' => enable_transferred_agent_first_message,
          'preserve_client_tts_overrides' => preserve_client_tts_overrides,
          'preserve_voice_settings' => preserve_voice_settings
        }.compact
        add_transfer(condition, destination.to_wire, ToolWire.value(options))
        self
      end

      protected

      def validate_tool
        transfers = @params['transfers']
        return [ToolIssue.error('no_transfers', 'transfer', "#{@system_tool_type} needs at least one transfer")] if TRANSFER_TYPES.include?(@system_tool_type) && (transfers.nil? || transfers.empty?)

        []
      end

      def to_wire
        @config.merge('type' => 'system', 'params' => { 'system_tool_type' => @system_tool_type }.merge(@params))
      end

      private

      def add_transfer(condition, model, options)
        unless TRANSFER_TYPES.include?(@system_tool_type)
          @issues << ToolIssue.error('invalid_option', 'transfer',
                                     "transfer only applies to transfer tools, not #{@system_tool_type}")
          return
        end
        to_number = @system_tool_type == 'transfer_to_number'
        if (model['type'] == 'phone_number') != to_number
          message = if to_number
                      "transfer_to_number needs a phone or SIP destination, not an agent (\"#{condition}\")"
                    else
                      "transfer_to_agent needs an agent destination (\"#{condition}\")"
                    end
          @issues << ToolIssue.error('invalid_destination', 'transfer', message)
          return
        end
        allowed = to_number ? PHONE_TRANSFER_OPTIONS : AGENT_TRANSFER_OPTIONS
        options.each_key do |key|
          next if allowed.include?(key)

          @issues << ToolIssue.error('invalid_option', key, "Option \"#{key}\" doesn't apply to #{@system_tool_type}")
        end
        settings = options.slice(*allowed)
        target = model.except('type')
        # A SIP URI held in a dynamic variable resolves to a SIP URI too, so it also needs SIP REFER.
        destination_type = target['transfer_destination']&.[]('type')
        if SIP_DESTINATIONS.include?(destination_type) && settings['transfer_type'] != 'sip_refer'
          @issues << ToolIssue.error('invalid_destination', 'transfer',
                                     "A SIP URI destination needs transfer_type: 'sip_refer' (\"#{condition}\")")
          return
        end
        @params['transfers'] = (@params['transfers'] || []) + [target.merge(settings).merge('condition' => condition)]
      end
    end
  end
end
