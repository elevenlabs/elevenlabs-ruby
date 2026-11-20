# frozen_string_literal: true

require 'json'
require_relative '../agent_workflows/wire'
require_relative '../agent_tools/wire'

module Elevenlabs
  module AgentBuilder
    # Helpers for agent configs in API wire format (snake_case JSON with string keys), shared with the tool and
    # workflow builders.
    module AgentWire
      module_function

      # A value given to the builder (a plain value, a generated model, or a symbol for an enum) in wire
      # format: string keys, and symbols as strings.
      def value(raw)
        AgentTools::ToolWire.value(raw)
      end

      def deep_copy(value)
        AgentWorkflows::Wire.deep_copy(value)
      end

      # Sorts keys at every level and writes whole floats as integers, as the JavaScript SDK does.
      def canonical(value)
        AgentTools::ToolWire.canonical(value)
      end

      # The value at +path+, or nil if any step is missing.
      def get_path(target, path)
        path.reduce(target) { |current, key| current.is_a?(::Hash) ? current[key] : nil }
      end

      # Whether +path+ is set, even to null.
      def path?(target, path)
        current = target
        path.each do |key|
          return false unless current.is_a?(::Hash) && current.key?(key)

          current = current[key]
        end
        true
      end

      # Sets the value at +path+, creating hashes along the way.
      def set_path(target, path, value)
        current = target
        path[0...-1].each do |key|
          current[key] = {} unless current[key].is_a?(::Hash)
          current = current[key]
        end
        current[path[-1]] = value
      end

      # Removes the key at +path+, if it's there.
      def delete_path(target, path)
        parent = get_path(target, path[0...-1])
        parent.delete(path[-1]) if parent.is_a?(::Hash)
      end

      # Merges +source+ into +target+: hashes merge key by key, anything else (arrays included) replaces.
      # Values are copied, so later edits to +source+ don't reach +target+.
      def deep_merge(target, source)
        source.each do |key, item|
          existing = target[key]
          if item.is_a?(::Hash) && existing.is_a?(::Hash)
            deep_merge(existing, item)
          else
            target[key] = deep_copy(item)
          end
        end
        target
      end

      # Whether every value in +local+ is in +remote+ at the same place. Extra keys in +remote+ (server
      # defaults) are fine, and a null in +local+ matches anything.
      def subset?(local, remote)
        case local
        when ::Array
          remote.is_a?(::Array) && local.length == remote.length &&
            local.each_with_index.all? { |item, i| subset?(item, remote[i]) }
        when ::Hash
          remote.is_a?(::Hash) && local.all? { |key, item| item.nil? || subset?(item, remote[key]) }
        when true, false
          local.equal?(remote)
        when ::Numeric
          # JSON can't tell 1 from 1.0, and a parsed response may hold either.
          remote.is_a?(::Numeric) && local == remote
        else
          local == remote
        end
      end

      # A generated response model back in wire format, with only the fields the response had.
      def response_wire(model)
        AgentWorkflows::Wire.to_wire(model)
      end

      # The tool ids an API-format workflow's nodes use: tool nodes' tools and subagents' extra tools.
      def raw_workflow_tool_ids(workflow)
        nodes = workflow.is_a?(::Hash) ? workflow['nodes'] : nil
        return [] unless nodes.is_a?(::Hash)

        nodes.values.flat_map do |node|
          next [] unless node.is_a?(::Hash)

          locators = node['tools'].is_a?(::Array) ? node['tools'] : []
          extra = node['additional_tool_ids'].is_a?(::Array) ? node['additional_tool_ids'] : []
          locators.filter_map { |locator| locator['tool_id'] if locator.is_a?(::Hash) && locator['tool_id'].is_a?(::String) } +
            extra.grep(::String)
        end
      end

      # Replaces the tool ids in an API-format workflow's tool nodes and subagents, in place, with the block's
      # result for each.
      def map_raw_workflow_tool_ids(workflow)
        nodes = workflow['nodes']
        return workflow unless nodes.is_a?(::Hash)

        nodes.each_value do |node|
          next unless node.is_a?(::Hash)

          if node['tools'].is_a?(::Array)
            node['tools'].each do |locator|
              locator['tool_id'] = yield(locator['tool_id']) if locator.is_a?(::Hash) && locator['tool_id'].is_a?(::String)
            end
          end
          node['additional_tool_ids'] = node['additional_tool_ids'].map { |id| id.is_a?(::String) ? yield(id) : id } if node['additional_tool_ids'].is_a?(::Array)
        end
        workflow
      end

      # Every tool id an agent config uses, in the agent's tool_ids and the workflow's nodes, once each, in order.
      def tool_ids_in(config)
        prompt_ids = get_path(config, Agent::TOOL_IDS_PATH)
        ((prompt_ids.is_a?(::Array) ? prompt_ids.grep(::String) : []) + raw_workflow_tool_ids(config['workflow'])).uniq
      end
    end

    # Checks a raw +conversation_config+ or +platform_settings+ hash against the generated model's declared
    # field types, the way the JS and Python SDKs check it with their serializers. The generated models coerce
    # leniently (a string becomes 0.0 in a number field), so they can't be relied on to reject a wrong value.
    # Unknown fields, enum values and unions are let through, so newer API settings still work.
    module ConfigCheck
      module_function

      # Raises ArgumentError naming the first value that doesn't fit +type+.
      def check!(type, value, path = [])
        resolved = ::Elevenlabs::Internal::Types::Utils.unwrap_type(type)
        return if value.nil?

        case resolved
        when ::Elevenlabs::Internal::Types::Array
          expect(value.is_a?(::Array), path, 'a list', value)
          value.each_with_index { |item, i| check!(resolved.type, item, path + [i.to_s]) }
        when ::Elevenlabs::Internal::Types::Hash
          expect(value.is_a?(::Hash), path, 'an object', value)
          value.each { |key, item| check!(resolved.value_type, item, path + [key.to_s]) }
        when ::Class
          check_class!(resolved, value, path)
        when ::Module
          check_module!(resolved, value, path)
        end
      end

      def check_class!(klass, value, path)
        if klass <= ::Elevenlabs::Internal::Types::Model
          return if value.is_a?(klass)

          expect(value.is_a?(::Hash), path, 'an object', value)
          fields = klass.fields.values.to_h { |field| [field.api_name.to_s, field] }
          value.each do |key, item|
            field = fields[key.to_s]
            check!(field.type, item, path + [key.to_s]) unless field.nil?
          end
        elsif klass <= ::String
          expect(value.is_a?(::String) || value.is_a?(::Symbol), path, 'a string', value)
        elsif klass <= ::Integer
          expect(value.is_a?(::Integer) || (value.is_a?(::Float) && value == value.to_i), path, 'an integer', value)
        elsif klass <= ::Float
          expect(value.is_a?(::Numeric), path, 'a number', value)
        end
      end

      def check_module!(mod, value, path)
        if mod == ::Elevenlabs::Internal::Types::Boolean
          expect([true, false].include?(value), path, 'true or false', value)
        elsif mod.singleton_class.include?(::Elevenlabs::Internal::Types::Enum)
          expect(value.is_a?(::String) || value.is_a?(::Symbol), path, 'a string', value)
        elsif mod.singleton_class.include?(::Elevenlabs::Internal::Types::Union)
          members = mod.members.map { |_key, type_fn| type_fn }
          errors = members.filter_map do |member|
            check!(member, value, path)
            nil
          rescue ArgumentError => e
            e
          end
          raise errors.first if !members.empty? && errors.length == members.length
        end
      end

      def expect(ok, path, wanted, value)
        return if ok

        where = path.empty? ? 'the value' : path.join('.')
        raise ArgumentError, "#{where} must be #{wanted}, not #{::JSON.generate(value)}"
      rescue ::JSON::GeneratorError
        raise ArgumentError, "#{where} must be #{wanted}"
      end
    end
  end
end
