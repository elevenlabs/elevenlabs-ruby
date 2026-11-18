# frozen_string_literal: true

require_relative 'wire'

module Elevenlabs
  module AgentWorkflows
    # Where a transfer() node hands the conversation off to.
    #
    # Use the static constructors. The model is the node fields the destination sets, in wire format.
    class Destination
      def initialize(model)
        @model = model
      end

      class << self
        # A phone number in E.164 format.
        def phone(phone_number)
          new('type' => 'phone_number',
              'transfer_destination' => { 'type' => 'phone', 'phone_number' => phone_number })
        end

        # A phone number read from a dynamic variable at transfer time.
        def phone_variable(variable_name)
          new('type' => 'phone_number',
              'transfer_destination' => { 'type' => 'phone_dynamic_variable', 'phone_number' => variable_name })
        end

        # A SIP URI.
        def sip(sip_uri)
          new('type' => 'phone_number',
              'transfer_destination' => { 'type' => 'sip_uri', 'sip_uri' => sip_uri })
        end

        # A SIP URI read from a dynamic variable at transfer time.
        def sip_variable(variable_name)
          new('type' => 'phone_number',
              'transfer_destination' => { 'type' => 'sip_uri_dynamic_variable', 'sip_uri' => variable_name })
        end

        # Another ElevenLabs agent. +node_id+ is the node in its workflow to start from.
        def agent(agent_id, node_id: nil)
          model = { 'type' => 'standalone_agent', 'agent_id' => agent_id }
          model['node_id'] = node_id unless node_id.nil?
          new(model)
        end
      end

      # The node fields this destination sets, in API wire format.
      def to_wire
        Wire.deep_copy(@model)
      end
    end
  end
end
