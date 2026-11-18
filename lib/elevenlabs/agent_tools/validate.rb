# frozen_string_literal: true

require_relative 'errors'
require_relative 'schema'

module Elevenlabs
  module AgentTools
    # @api private — the schema rules every tool kind shares.
    module Validate
      module_function

      # Checks a schema and everything under it, appending to +issues+. +path+ names it in messages, e.g.
      # "body.reason". +is_property+ is whether the schema is a property (or a param), so omit() needs it
      # to be optional.
      def check_schema(schema, path, is_property, issues)
        s = schema.state
        # The API reads "" as unset, so an empty description or variable name isn't a value source.
        described = present?(s[:description])
        sources = [described, present?(s[:dynamic_variable]), s[:has_constant], s[:system_provided], s[:omitted]]
                  .count(true)
        if sources > 1
          issues << error('conflicting_value_source', path,
                          "\"#{path}\" sets more than one of describe, from_variable, constant, system_provided and omit")
        end
        issues << error('omitted_required', path, "\"#{path}\" uses omit, so it must be optional") if s[:omitted] && is_property && !s[:optional]
        issues << error('invalid_choices', path, "\"#{path}\" uses choices, which only applies to strings") if !s[:choices].nil? && s[:kind] != 'string'
        if !s[:allowed_from].nil? && !described
          issues << error('allowed_values_needs_description', path,
                          "\"#{path}\" uses allowed_from, which needs describe so the LLM provides the value")
        end
        check_constant(s, path, issues)
        # The API rejects a literal with no value source wherever it appears, response schemas included.
        if sources.zero? && literal?(s[:kind])
          issues << error('missing_value_source', path,
                          "\"#{path}\" needs one of describe, from_variable, constant, system_provided or omit")
        end

        check_children(s, path, issues)
      end

      def literal?(kind)
        kind != 'object' && kind != 'array'
      end

      def error(code, path, message)
        ToolIssue.error(code, path, message)
      end

      def present?(text)
        !text.nil? && text != ''
      end

      def check_constant(state, path, issues)
        return unless state[:has_constant]

        if !matches_kind?(state[:kind], state[:constant_value], nullable?(state[:literal_type]))
          issues << error('constant_type_mismatch', path, "\"#{path}\" has a constant that isn't a #{state[:kind]}")
        elsif state[:constant_value] == ''
          issues << error('constant_type_mismatch', path,
                          "\"#{path}\" can't have \"\" as a constant: the API reads it as unset")
        end
      end

      def check_children(state, path, issues)
        case state[:kind]
        when 'object'
          names = state[:properties].map(&:first)
          (state[:any_of] + state[:all_of]).each do |group|
            group.reject { |name| names.include?(name) }.each do |name|
              issues << error('unknown_required_property', path,
                              "\"#{path}\" requires \"#{name}\" in require_any_of/require_all_of, but has no such property")
            end
          end
          state[:properties].each { |(name, child)| check_schema(child, "#{path}.#{name}", true, issues) }
        when 'array'
          if state[:items].nil?
            issues << error('missing_array_items', path, "Array \"#{path}\" has no items schema")
          else
            check_schema(state[:items], "#{path}[]", false, issues)
          end
        end
      end

      # Whether a loaded literal's +type+ is a list that includes "null", e.g. ["integer", "null"].
      def nullable?(type)
        type.is_a?(::Array) && type.include?('null')
      end

      def matches_kind?(kind, value, nullable)
        return true if value.nil? && nullable

        case kind
        when 'string' then value.is_a?(::String)
        when 'integer' then value.is_a?(::Integer) || (value.is_a?(::Float) && value.finite? && value == value.floor)
        when 'number' then value.is_a?(::Numeric)
        when 'boolean' then [true, false].include?(value)
        when 'object' then value.is_a?(::Hash)
        when 'array' then value.is_a?(::Array)
        else false
        end
      end
    end
  end
end
