# frozen_string_literal: true

require_relative 'condition'
require_relative 'destination'
require_relative 'graph'

module Elevenlabs
  module AgentWorkflows
    # Where the next edge starts and which conditions it carries.
    EdgeOrigin = Struct.new(:source, :forward_condition, :backward_condition)

    # The verbs that add a node and connect it to the current point in the workflow. Each returns the
    # new node, so linear flows chain: wf.converse(...).when('...').tool(...).
    class WorkflowChain
      def initialize(graph)
        @graph = graph
      end

      # The agent holds a conversation with +prompt+ added to its instructions until an outgoing
      # condition holds (a subagent node). +label+ defaults to +id+.
      def converse(id, prompt, position: nil, label: nil, tool_ids: nil, knowledge_base: nil,
                   conversation_config: nil, entry_behavior: nil)
        model = @graph.apply_options(
          id,
          { 'type' => 'override_agent', 'label' => id, 'additional_prompt' => prompt },
          {
            'position' => position, 'label' => label, 'tool_ids' => tool_ids,
            'knowledge_base' => knowledge_base, 'conversation_config' => conversation_config,
            'entry_behavior' => entry_behavior
          },
        )
        @graph.add_node(id, model)
        connect(id)
      end

      # Runs the tools in parallel. Branch on the result with on_result, or on_success and on_failure.
      def tool(id, tool_ids, position: nil, schema_overrides: nil)
        model = @graph.apply_options(
          id,
          { 'type' => 'tool' },
          { 'position' => position, 'schema_overrides' => schema_overrides, 'tool_ids' => tool_ids.to_a },
        )
        @graph.add_node(id, model)
        connect(id)
      end

      # Transfers the conversation to a phone number, SIP URI or another agent.
      def transfer(id, destination, position: nil, transfer_type: nil, custom_sip_headers: nil,
                   sip_refer_play_dialtone: nil, uui: nil, post_dial_digits: nil, delay_ms: nil,
                   transfer_message: nil, enable_transferred_agent_first_message: nil,
                   preserve_client_tts_overrides: nil, preserve_voice_settings: nil)
        model = @graph.apply_options(
          id,
          destination.to_wire,
          {
            'position' => position, 'transfer_type' => transfer_type, 'custom_sip_headers' => custom_sip_headers,
            'sip_refer_play_dialtone' => sip_refer_play_dialtone, 'uui' => uui,
            'post_dial_digits' => post_dial_digits, 'delay_ms' => delay_ms, 'transfer_message' => transfer_message,
            'enable_transferred_agent_first_message' => enable_transferred_agent_first_message,
            'preserve_client_tts_overrides' => preserve_client_tts_overrides,
            'preserve_voice_settings' => preserve_voice_settings
          },
        )
        @graph.add_node(id, model)
        connect(id)
      end

      # Ends the conversation. Every end() without an id shares one end node, "end".
      def end(id: 'end', position: nil)
        @graph.add_node(id, @graph.apply_options(id, { 'type' => 'end' }, { 'position' => position }))
        connect(id)
      end

      # Moves the conversation to a node that already exists (or will by build() time), for merges and
      # loops. +back+ is the condition for coming back along this edge, from the target to here.
      def go_to(target, back: nil)
        connect(target.is_a?(::String) ? target : target.id, back)
      end

      # @api private
      def origin
        raise NotImplementedError
      end

      private

      def connect(target, back = nil)
        o = origin
        @graph.edges << GraphEdge.new(
          source: o.source,
          target: target,
          forward_condition: o.forward_condition,
          backward_condition: back.nil? ? o.backward_condition : AgentWorkflows.to_condition(back).to_wire,
        )
        WorkflowNode.new(@graph, target, o.source)
      end
    end

    # A pending edge out of a node, opened by when(), on_success() or on_failure().
    class WorkflowBranch < WorkflowChain
      def initialize(graph, origin)
        super(graph)
        @from = origin
      end

      def origin
        @from
      end
    end

    # A handle to one node in a workflow. Handles are cheap: all state lives in the Workflow.
    class WorkflowNode < WorkflowChain
      attr_reader :id

      def initialize(graph, id, parent_id = nil)
        super(graph)
        @id = id
        @parent_id = parent_id
      end

      # The API node type, for example "override_agent" or "tool".
      def type
        model = @graph.nodes[@id]
        model&.[]('type')
      end

      # Opens a branch followed when +condition+ holds. A string is an LLM condition. +back+ is the
      # condition for coming back along the edge, from the new node to this one.
      def when(condition, back: nil)
        AgentWorkflows.branch(@graph, @id, condition, back)
      end

      # Returns the node this handle was chained from, so a whole workflow can be written as one chain.
      def up
        parent = @parent_id
        if parent.nil?
          edge = @graph.edges.find { |e| e.target == @id && e.source != @id }
          parent = edge ? edge.source : @graph.start_id
        end
        WorkflowNode.new(@graph, parent)
      end

      # Opens the branch followed when every tool in this tool node succeeded.
      def on_success(label: nil)
        AgentWorkflows.branch(@graph, @id, Condition.success(label: label))
      end

      # Opens the branch followed when any tool in this tool node failed.
      def on_failure(label: nil)
        AgentWorkflows.branch(@graph, @id, Condition.failure(label: label))
      end

      # Routes both outcomes of this tool node in one place. Same as on_success() then on_failure(), so
      # the success edge always comes first. Either may be omitted. Returns this node.
      def on_result(success: nil, failure: nil)
        success&.call(on_success)
        failure&.call(on_failure)
        self
      end

      # Changes this node's options. Only options that apply to the node's kind may be set; build()
      # reports the rest.
      def update(prompt: nil, tool_ids: nil, destination: nil, position: nil, label: nil, knowledge_base: nil,
                 conversation_config: nil, entry_behavior: nil, schema_overrides: nil, transfer_type: nil,
                 custom_sip_headers: nil, sip_refer_play_dialtone: nil, uui: nil, post_dial_digits: nil,
                 delay_ms: nil, transfer_message: nil, enable_transferred_agent_first_message: nil,
                 preserve_client_tts_overrides: nil, preserve_voice_settings: nil)
        model = @graph.nodes[@id]
        if model.nil?
          @graph.issue('unknown_node', "Can't update unknown node \"#{@id}\"", @id)
        else
          options = {
            'prompt' => prompt, 'tool_ids' => tool_ids, 'destination' => destination, 'position' => position,
            'label' => label, 'knowledge_base' => knowledge_base, 'conversation_config' => conversation_config,
            'entry_behavior' => entry_behavior, 'schema_overrides' => schema_overrides,
            'transfer_type' => transfer_type, 'custom_sip_headers' => custom_sip_headers,
            'sip_refer_play_dialtone' => sip_refer_play_dialtone, 'uui' => uui,
            'post_dial_digits' => post_dial_digits, 'delay_ms' => delay_ms, 'transfer_message' => transfer_message,
            'enable_transferred_agent_first_message' => enable_transferred_agent_first_message,
            'preserve_client_tts_overrides' => preserve_client_tts_overrides,
            'preserve_voice_settings' => preserve_voice_settings
          }
          @graph.nodes[@id] = @graph.apply_options(@id, model, options)
        end
        self
      end

      def origin
        EdgeOrigin.new(source: @id, forward_condition: Condition.always.to_wire, backward_condition: nil)
      end
    end

    module_function

    def branch(graph, source, condition, back = nil)
      WorkflowBranch.new(
        graph,
        EdgeOrigin.new(
          source: source,
          forward_condition: to_condition(condition).to_wire,
          backward_condition: back.nil? ? nil : to_condition(back).to_wire,
        ),
      )
    end
  end
end
