# frozen_string_literal: true

require_relative 'wire'
require_relative 'expr'

module Elevenlabs
  module AgentWorkflows
    # When an edge may be followed. A plain string passed to when() is shorthand for Condition.llm, and
    # an Expr is shorthand for Condition.expr. +label+ is shown on the edge in the workflow editor.
    #
    # Use the static constructors; the condition is kept in wire format.
    class Condition
      def initialize(model)
        @model = model
      end

      class << self
        # Followed when the LLM judges +condition+ to be true.
        def llm(condition, label: nil)
          new(labelled({ 'type' => 'llm', 'condition' => condition }, label))
        end

        # Followed when +expression+ evaluates to true.
        def expr(expression, label: nil)
          new(labelled({ 'type' => 'expression', 'expression' => expression.to_wire }, label))
        end

        # Always followed.
        def always(label: nil)
          new(labelled({ 'type' => 'unconditional' }, label))
        end

        # Followed when every tool in a tool node succeeded.
        def success(label: nil)
          new(labelled({ 'type' => 'result', 'successful' => true }, label))
        end

        # Followed when any tool in a tool node failed.
        def failure(label: nil)
          new(labelled({ 'type' => 'result', 'successful' => false }, label))
        end

        # @api private
        def labelled(model, label)
          model['label'] = label unless label.nil?
          model
        end
      end

      # The condition in API wire format.
      def to_wire
        Wire.deep_copy(@model)
      end
    end

    module_function

    # Coerce a condition input (Condition, Expr or String) into a Condition.
    def to_condition(value)
      case value
      when Condition then value
      when Expr then Condition.expr(value)
      else Condition.llm(value)
      end
    end
  end
end
