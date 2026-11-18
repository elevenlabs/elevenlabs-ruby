# frozen_string_literal: true

require 'json'
require_relative 'wire'

module Elevenlabs
  module AgentTools
    # A tool param's JSON schema, and where its value comes from. Schemas are values: every method returns a
    # new schema and never changes the one it is called on, so one schema can be reused across tools and
    # properties.
    #
    #   Schema.object
    #         .property('order_id', Schema.string.from_variable('order_id'))
    #         .property('reason', Schema.string.describe('Why the caller wants a refund').choices(%w[damaged late]))
    #         .property('note', Schema.string.describe('Anything else the caller said').optional)
    class Schema
      # Wire keys the builder models. Anything else on a loaded schema is written back unchanged.
      MODELED_KEYS = %w[
        type description dynamic_variable constant_value is_system_provided is_omitted enum allowed_values
        items properties required required_constraints
      ].freeze

      LITERAL_KINDS = %w[string integer number boolean].freeze

      INITIAL_STATE = {
        kind: nil,
        literal_type: nil,
        description: nil,
        dynamic_variable: nil,
        has_constant: false,
        constant_value: nil,
        system_provided: false,
        omitted: false,
        optional: false,
        choices: nil,
        allowed_from: nil,
        items: nil,
        properties: [].freeze,
        loaded_required: nil,
        any_of: [].freeze,
        all_of: [].freeze,
        extra: {}.freeze,
      }.freeze

      # @api private — use the static constructors.
      def initialize(state)
        @state = state.freeze
      end

      class << self
        # A string.
        def string
          LiteralSchema.new(initial('string'))
        end

        # An integer.
        def integer
          LiteralSchema.new(initial('integer'))
        end

        # A number.
        def number
          LiteralSchema.new(initial('number'))
        end

        # A boolean. Named +bool+ to match the other SDKs (+boolean+ is reserved in Java).
        def bool
          LiteralSchema.new(initial('boolean'))
        end

        # An object. Add properties with +property+.
        def object
          ObjectSchema.new(initial('object'))
        end

        # An array whose elements match +items+.
        def array(items)
          ArraySchema.new(initial('array').merge(items: items))
        end

        # Loads a schema in API format (snake_case), given as a JSON string or a parsed hash.
        def from_json(data)
          from_wire(ToolWire.parse(data))
        end

        # @api private — loads a wire-format schema where the API expects an object (a body, a response, the
        # query params or a client tool's params). It's an object when it has no +type+, since an empty
        # schema has none, and is then written with "type": "object". A declared +type+ is kept, so
        # validation can report a schema that isn't an object.
        def from_wire_object(model)
          from_wire(model, kind: model.key?('type') ? kind_of(model) : 'object')
        end

        # @api private — loads a wire-format schema. +optional+ is whether its parent leaves it out of
        # +required+.
        def from_wire(model, optional: false, kind: kind_of(model))
          # A null constant is a value only on a literal whose type list includes "null"; anywhere else it
          # means unset, like every other null the API sends.
          if model.key?('constant_value') && model['constant_value'].nil? &&
             !(LITERAL_KINDS.include?(kind) && nullable_type?(model['type']))
            model = model.except('constant_value')
          end
          # The API fills unset fields with defaults ("", false, []). They aren't value sources, but are kept
          # as extra fields so a pulled config writes back unchanged.
          extra = model.reject { |key, value| MODELED_KEYS.include?(key) && !unset?(key, value, kind) }
          set = ->(key) { unset?(key, model[key], kind) ? nil : model[key] }
          base = initial(kind).merge(
            description: set.call('description'),
            dynamic_variable: set.call('dynamic_variable'),
            has_constant: model.key?('constant_value') && !unset?('constant_value', model['constant_value'], kind),
            constant_value: set.call('constant_value'),
            omitted: model['is_omitted'] == true,
            optional: optional,
            extra: ToolWire.deep_copy(extra),
          )
          case kind
          when 'object' then load_object(model, base, set)
          when 'array'
            items = set.call('items')
            ArraySchema.new(base.merge(items: items.nil? ? nil : from_wire(items, optional: true)))
          else
            allowed = set.call('allowed_values')
            LiteralSchema.new(
              base.merge(
                literal_type: ToolWire.deep_copy(model['type']),
                system_provided: model['is_system_provided'] == true,
                choices: set.call('enum')&.dup,
                allowed_from: allowed.is_a?(::Hash) ? allowed['dynamic_variable'] : nil,
              ),
            )
          end
        end

        # @api private
        def initial(kind)
          INITIAL_STATE.merge(kind: kind)
        end

        # @api private — whether a literal's +type+ is a list that includes "null", e.g. ["integer", "null"].
        def nullable_type?(type)
          type.is_a?(::Array) && type.include?('null')
        end

        # @api private — the kind of a wire schema. A literal's type can be a list such as
        # ["integer", "null"]; its kind is the non-null member.
        def kind_of(model)
          type = model['type']
          return 'object' if type == 'object' || (type.nil? && model.key?('properties'))
          return 'array' if type == 'array' || (type.nil? && model.key?('items'))

          type = type.find { |t| t != 'null' } if type.is_a?(::Array)
          %w[integer number boolean].include?(type) ? type : 'string'
        end

        private

        def load_object(model, base, set)
          required = set.call('required').is_a?(::Array) ? model['required'].dup : nil
          constraints = model['required_constraints'].is_a?(::Hash) ? model['required_constraints'] : {}
          properties = (set.call('properties') || {}).map do |name, child|
            [name, from_wire(child, optional: !(required || []).include?(name))].freeze
          end
          ObjectSchema.new(
            base.merge(
              properties: properties.freeze,
              loaded_required: required,
              any_of: (constraints['any_of'] || []).map { |c| c['required'].dup },
              all_of: (constraints['all_of'] || []).map { |c| c['required'].dup },
            ),
          )
        end

        # Whether +value+ is what the API returns for an unset field. A literal's unset constant is "", so
        # "" can't be a constant.
        def unset?(key, value, kind)
          case key
          when 'description', 'dynamic_variable' then value == ''
          when 'constant_value' then LITERAL_KINDS.include?(kind) && value == ''
          when 'is_system_provided', 'is_omitted' then value == false
          when 'required' then value.is_a?(::Array) && value.empty?
          when 'properties' then value.is_a?(::Hash) && value.empty?
          else false
          end
        end
      end

      # "string", "integer", "number", "boolean", "object" or "array".
      def kind
        @state[:kind]
      end

      # Whether the parent leaves this property out of +required+.
      def optional?
        @state[:optional]
      end

      # The LLM provides the value, guided by +text+. On an object or array, documents the container.
      def describe(text)
        with(description: text)
      end

      # The value is read from the dynamic variable +name+ when the tool runs.
      def from_variable(name)
        with(dynamic_variable: name)
      end

      # The value is always +value+, a JSON value matching the schema's type.
      def constant(value)
        with(has_constant: true, constant_value: ToolWire.value(value))
      end

      # The param is left out of the request. Only allowed on an optional property.
      def omit
        with(omitted: true)
      end

      # Leaves this property out of its parent's +required+. Properties are required unless marked optional.
      def optional
        with(optional: true)
      end

      # The schema in API format (snake_case keys, sorted at every level). Doesn't validate.
      def to_json(*_args)
        ToolWire.canonical(to_wire)
      end

      # @api private
      attr_reader :state

      # @api private — the schema in wire format, unsorted.
      def to_wire
        s = @state
        # Modeled fields that are unset leave the matching extra field (an API default) in place.
        wire = ToolWire.deep_copy(s[:extra])
        wire['description'] = s[:description] unless s[:description].nil?
        wire['dynamic_variable'] = s[:dynamic_variable] unless s[:dynamic_variable].nil?
        wire['is_omitted'] = true if s[:omitted]
        wire['constant_value'] = ToolWire.deep_copy(s[:constant_value]) if s[:has_constant]
        add_kind_fields(wire)
        wire
      end

      protected

      def with(changes)
        self.class.new(@state.merge(changes))
      end

      def add_kind_fields(wire)
        s = @state
        wire['type'] = s[:literal_type].nil? ? s[:kind] : ToolWire.deep_copy(s[:literal_type])
        wire['is_system_provided'] = true if s[:system_provided]
        wire['enum'] = s[:choices].dup unless s[:choices].nil?
        wire['allowed_values'] = { 'dynamic_variable' => s[:allowed_from] } unless s[:allowed_from].nil?
      end
    end

    # A string, integer, number or boolean.
    class LiteralSchema < Schema
      # The values the LLM may choose from (+enum+). Strings only. Named +choices+ because +enum+ is reserved
      # in other SDK languages.
      def choices(values)
        with(choices: values.map { |value| ToolWire.value(value) }.freeze)
      end

      # The value is filled in by the system at runtime.
      def system_provided
        with(system_provided: true)
      end

      # Rejects an LLM value that isn't in the list held by the dynamic variable +variable+. The list isn't
      # shown to the LLM. Needs +describe+.
      def allowed_from(variable)
        with(allowed_from: variable)
      end
    end

    # An object with named properties.
    class ObjectSchema < Schema
      # Adds the property +name+, or replaces it in place if it exists.
      def property(name, schema)
        properties = @state[:properties].dup
        index = properties.index { |(existing, _)| existing == name }
        if index.nil?
          properties << [name, schema].freeze
        else
          properties[index] = [name, schema].freeze
        end
        with(properties: properties.freeze)
      end

      # Removes the property +name+.
      def without(name)
        with(properties: @state[:properties].reject { |(existing, _)| existing == name }.freeze)
      end

      # Requires at least one of these sets of properties: appends +names+ to required_constraints.any_of.
      def require_any_of(names)
        with(any_of: (@state[:any_of] + [names.dup]).freeze)
      end

      # Requires all of these sets of properties: appends +names+ to required_constraints.all_of.
      def require_all_of(names)
        with(all_of: (@state[:all_of] + [names.dup]).freeze)
      end

      # Property names, in order.
      def property_names
        @state[:properties].map(&:first)
      end

      # The schema of property +name+, or nil if there is none.
      def property_schema(name)
        @state[:properties].find { |(existing, _)| existing == name }&.last
      end

      protected

      def add_kind_fields(wire)
        s = @state
        wire['type'] = 'object'
        wire['properties'] = s[:properties].to_h { |(name, child)| [name, child.to_wire] } unless s[:properties].empty?
        required = required_names
        wire['required'] = required unless required.empty?
        constraints = {}
        constraints['any_of'] = s[:any_of].map { |names| { 'required' => names.dup } } unless s[:any_of].empty?
        constraints['all_of'] = s[:all_of].map { |names| { 'required' => names.dup } } unless s[:all_of].empty?
        wire['required_constraints'] = constraints unless constraints.empty?
      end

      private

      # A loaded object's +required+ order for the required properties it still has, then new ones in
      # property order.
      def required_names
        required = @state[:properties].reject { |(_, child)| child.optional? }.map(&:first)
        kept = (@state[:loaded_required] || []).select { |name| required.include?(name) }
        kept + required.reject { |name| kept.include?(name) }
      end
    end

    # A list whose elements match one schema.
    class ArraySchema < Schema
      # The element schema.
      def items
        @state[:items]
      end

      protected

      def add_kind_fields(wire)
        wire['type'] = 'array'
        wire['items'] = @state[:items].to_wire unless @state[:items].nil?
      end
    end
  end
end
