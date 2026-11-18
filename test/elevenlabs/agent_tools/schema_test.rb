# frozen_string_literal: true

require_relative 'support'

module Elevenlabs
  module AgentTools
    class SchemaTest < Minitest::Test
      include Support

      def test_methods_return_a_new_schema_and_leave_the_original_unchanged
        base = Schema.string
        base.describe('A')

        assert_equal({ 'type' => 'string' }, base.to_json)
      end

      def test_methods_keep_the_subtype
        assert_instance_of LiteralSchema, Schema.string.describe('A').optional
      end

      def test_bool_is_a_boolean_literal
        assert_equal 'boolean', Schema.bool.kind
      end

      def test_a_shared_schema_edited_for_one_tool_leaves_the_others_alone
        order_id = Schema.string.describe('The order number')
        lookup = Tool.webhook('lookup', 'Look up').get('https://api.example.com/{id}').path_param('id', order_id)
        cancel = Tool.webhook('cancel', 'Cancel').post('https://api.example.com/cancel')
                     .body(Schema.object.property('id', order_id))
        cancel.body(cancel.body_schema.property('id', order_id.optional))

        assert_equal({ 'id' => { 'description' => 'The order number', 'type' => 'string' } },
                     lookup.to_json['api_schema']['path_params_schema'])
      end

      def test_an_optional_property_is_left_out_of_required
        cancel = Tool.webhook('cancel', 'Cancel').post('https://api.example.com/cancel')
                     .body(Schema.object.property('id', Schema.string.describe('Id').optional))

        assert_equal({ 'properties' => { 'id' => { 'description' => 'Id', 'type' => 'string' } }, 'type' => 'object' },
                     cancel.to_json['api_schema']['request_body_schema'])
      end

      def test_loads_properties_not_in_required_as_optional
        schema = Schema.from_json(
          'properties' => { 'a' => { 'type' => 'string' }, 'b' => { 'type' => 'string' } },
          'required' => ['a'],
          'type' => 'object',
        )

        assert_equal([false, true], %w[a b].map { |name| schema.property_schema(name).optional? })
      end

      def test_loads_a_json_string
        schema = Schema.from_json('{"type": "integer", "description": "N"}')

        assert_equal({ 'description' => 'N', 'type' => 'integer' }, schema.to_json)
      end

      def test_array_items_are_readable
        assert_equal 'string', Schema.array(Schema.string.describe('A tag')).items.kind
      end

      def test_symbols_are_written_as_strings
        assert_equal({ 'enum' => %w[a b], 'type' => 'string' }, Schema.string.choices(%i[a b]).to_json)
      end
    end
  end
end
