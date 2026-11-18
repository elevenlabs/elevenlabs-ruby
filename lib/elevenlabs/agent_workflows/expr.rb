# frozen_string_literal: true

require_relative 'wire'

module Elevenlabs
  module AgentWorkflows
    # A workflow expression, compiled to the API's expression AST.
    #
    # Use the static constructors; the AST is kept in wire format. Instance methods (eq, neq, gt, gte,
    # lt, lte, add, sub, mul, div) each take an Expr or a plain value, which becomes a literal.
    #
    #   Expr.any_of(Expr.variable('tier').eq('gold'), Expr.variable('orders').gte(10))
    class Expr
      # LLM value types for Expr.llm: 'boolean' (default), 'string', 'integer', 'number'.
      def initialize(node)
        @node = node
      end

      class << self
        # The value of a dynamic variable.
        def variable(name)
          new('type' => 'dynamic_variable', 'name' => name)
        end

        # A string, number, boolean or null literal.
        def literal(value)
          case value
          when nil
            new('type' => 'null_literal')
          when true, false
            new('type' => 'boolean_literal', 'value' => value)
          when ::String
            new('type' => 'string_literal', 'value' => value)
          else
            new('type' => 'number_literal', 'value' => value)
          end
        end

        # A value the LLM extracts from the conversation, described by +description+. +type+ defaults to
        # 'boolean'; +enum+ lists the allowed values of a 'string'.
        def llm(description, type: 'boolean', enum: nil)
          schema = { 'type' => type, 'description' => description }
          schema['enum'] = enum.to_a unless enum.nil?
          new('type' => 'llm', 'value_schema' => schema)
        end

        # True when every expression is true.
        def all_of(*exprs)
          new('type' => 'and_operator', 'children' => exprs.map { |expr| to_ast(expr) })
        end

        # True when at least one expression is true.
        def any_of(*exprs)
          new('type' => 'or_operator', 'children' => exprs.map { |expr| to_ast(expr) })
        end

        # +when_true+ if +condition+ is true, otherwise +when_false+.
        def if_else(condition, when_true, when_false)
          new(
            'type' => 'conditional_operator',
            'condition' => to_ast(condition),
            'trueExpression' => to_ast(when_true),
            'falseExpression' => to_ast(when_false),
          )
        end

        # Wraps an existing AST node: a generated model, or a hash in wire format.
        def from_model(node)
          new(Wire.to_wire(node))
        end

        # @api private
        def to_ast(value)
          value.is_a?(Expr) ? value.to_wire : literal(value).to_wire
        end
      end

      def eq(other) = binary('eq_operator', other)
      def neq(other) = binary('neq_operator', other)
      def gt(other) = binary('gt_operator', other)
      def gte(other) = binary('gte_operator', other)
      def lt(other) = binary('lt_operator', other)
      def lte(other) = binary('lte_operator', other)
      def add(other) = binary('add_operator', other)
      def sub(other) = binary('sub_operator', other)
      def mul(other) = binary('mul_operator', other)
      def div(other) = binary('div_operator', other)

      # The expression in API wire format.
      def to_wire
        Wire.deep_copy(@node)
      end

      private

      def binary(type, other)
        self.class.new('type' => type, 'left' => to_wire, 'right' => self.class.to_ast(other))
      end
    end
  end
end
