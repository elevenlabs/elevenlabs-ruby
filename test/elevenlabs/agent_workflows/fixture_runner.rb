# frozen_string_literal: true

require 'json'
require 'elevenlabs'
require 'elevenlabs/agent_workflows'

module Elevenlabs
  module AgentWorkflows
    # Interprets the language-neutral fixtures in fixtures/, copied from the reference SDK
    # (elevenlabs-js, docs/agents-as-code). See workflow-spec.md there, "Fixtures".
    module FixtureRunner
      RESULT_KEYS = %w[success failure].freeze

      module_function

      def condition(raw)
        return raw if raw.is_a?(::String)
        return Condition.llm(raw['llm'], label: raw['label']) if raw.key?('llm')

        # The fixture 'expr' is wire-format AST; wrap it verbatim (snake/camel casing is preserved).
        Condition.expr(Expr.from_model(raw['expr']), label: raw['label'])
      end

      def destination(raw)
        return Destination.phone(raw['phone']) if raw.key?('phone')
        return Destination.phone_variable(raw['phoneVariable']) if raw.key?('phoneVariable')
        return Destination.sip(raw['sip']) if raw.key?('sip')
        return Destination.sip_variable(raw['sipVariable']) if raw.key?('sipVariable')

        Destination.agent(raw['agent'], node_id: raw['nodeId'])
      end

      def snake(name)
        name.gsub(/(?<!^)(?=[A-Z])/, '_').downcase
      end

      # Option keys are canonical camelCase names; nested values are in API wire format, passed verbatim.
      def options(op)
        opts = {}
        (op['options'] || {}).each { |key, value| opts[snake(key).to_sym] = value }
        opts[:destination] = destination(opts[:destination]) if opts.key?(:destination)
        opts
      end

      def run(wf, ops, first)
        previous = first
        result = nil
        ops.each do |op|
          case op['op']
          when 'update'
            wf.node(op['node']).update(**options(op))
            next
          when 'remove'
            wf.remove(op['node'])
            next
          when 'onResult'
            node = op.key?('at') ? wf.node(op['at']) : previous
            branches = {}
            op.each_key do |key|
              branches[key.to_sym] = ->(branch) { run(wf, op[key], branch) } if RESULT_KEYS.include?(key)
            end
            node.on_result(**branches)
            next
          when 'insertBetween'
            wf.insert_between(op['source'], op['target'], ->(from) { run(wf, op['ops'] || [], from) })
            next
          end

          at = if !op.key?('at')
                 previous
               elsif op['at'] == '$start'
                 wf
               else
                 wf.node(op['at'])
               end
          if op.key?('when')
            at = at.when(condition(op['when']), back: op.key?('back') ? condition(op['back']) : nil)
          elsif op['onSuccess']
            at = at.on_success
          elsif op['onFailure']
            at = at.on_failure
          end

          result =
            case op['op']
            when 'converse' then at.converse(op['id'], op['prompt'], **options(op))
            when 'tool' then at.tool(op['id'], op['toolIds'], **options(op))
            when 'transfer' then at.transfer(op['id'], destination(op['destination']), **options(op))
            when 'end' then at.end(**options(op))
            when 'goTo' then at.go_to(op['target'], back: op.key?('back') ? condition(op['back']) : nil)
            else raise "Unknown fixture op #{op['op'].inspect}"
            end
          previous = result
        end
        result
      end

      # Runs a fixture and returns { json: ... } with the canonical JSON string, or { errors: [...] }.
      def run_fixture(fixture)
        wf = if fixture.key?('from')
               Workflow.from_json(fixture['from'])
             else
               Workflow.new(prevent_subagent_loops: (fixture['workflow'] || {})['preventSubagentLoops'])
             end
        run(wf, fixture['ops'], wf)
        begin
          { json: wf.to_json_string }
        rescue WorkflowValidationError => e
          { errors: e.issues.map(&:code) }
        end
      end
    end
  end
end
