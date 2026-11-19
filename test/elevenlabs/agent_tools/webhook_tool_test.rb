# frozen_string_literal: true

require 'webmock/minitest'
require_relative 'support'

module Elevenlabs
  module AgentTools
    class WebhookToolTest < Minitest::Test
      include Support

      NOTE_BODY = Schema.object.property('note', Schema.string.describe('A note'))
      NOTES_URL = 'https://api.example.com/notes'

      def teardown
        WebMock.reset!
      end

      def test_build_returns_the_generated_request_model
        request = get_order.build

        assert_instance_of ::Elevenlabs::Types::ToolRequestModel, request
      end

      def test_build_holds_the_generated_webhook_config
        assert_instance_of ::Elevenlabs::Types::WebhookToolConfigInput, get_order.build.tool_config
      end

      def test_build_serializes_to_the_wire_format
        tool = get_order.header('Authorization', Header.secret('sec_1')).options(response_timeout_secs: 10)

        assert_equal tool.to_json, ToolWire.canonical(::JSON.parse(::JSON.generate(tool.build.to_h['tool_config'])))
      end

      def test_tools_create_sends_the_built_tool
        stub = stub_request(:post, 'https://api.test/v1/convai/tools')
               .with(body: ->(body) { ::JSON.parse(body) == { 'tool_config' => get_order.to_json } })
               .to_return(status: 200, body: ::JSON.generate(id: 'tool_1'), headers: { 'Content-Type' => 'application/json' })
        client = ::Elevenlabs::Client.new(api_key: 'test-key', base_url: 'https://api.test', max_retries: 0)
        client.agents.tools.create(**get_order.build.to_h)

        assert_requested stub
      end

      def test_options_accept_symbols_for_enums
        assert_equal 'force', get_order.options(pre_tool_speech: :force).to_json['pre_tool_speech']
      end

      def test_options_that_apply_to_other_kinds_are_reported
        assert_equal([%w[invalid_option expects_response]],
                     codes_and_paths_of { get_order.options(expects_response: true).build })
      end

      def test_replaces_a_param_with_the_same_name_in_place
        tool = Tool.webhook('search', 'Search').get('https://api.example.com/search')
                   .query_param('q', Schema.string.describe('Query'))
                   .query_param('limit', Schema.integer.constant(10))
                   .query_param('q', Schema.string.describe('Search terms'))

        assert_equal(
          {
            'properties' => {
              'limit' => { 'constant_value' => 10, 'type' => 'integer' },
              'q' => { 'description' => 'Search terms', 'type' => 'string' },
            },
            'required' => %w[q limit],
          },
          tool.to_json['api_schema']['query_params_schema'],
        )
      end

      def test_removes_params_headers_and_assignments
        json = get_order.query_param('q', Schema.string.describe('Query')).header('X-A', Header.value('1'))
                        .assign('a', 'a').assign('b', 'b')
                        .remove_query_param('q').remove_header('X-A').remove_assignment('a').to_json

        assert_equal [nil, nil, [{ 'dynamic_variable' => 'b', 'source' => 'response', 'value_path' => 'b' }]],
                     [json['api_schema']['query_params_schema'], json['api_schema']['request_headers'], json['assignments']]
      end

      def test_removing_what_does_not_exist_does_nothing
        tool = get_order.remove_assignment('a').remove_header('X-A').remove_query_param('q').remove_path_param('x')

        assert_equal get_order.to_json, tool.to_json
      end

      def test_exposes_the_body_schema_for_editing
        tool = Tool.webhook('refund', 'Refund').post('https://api.example.com/refunds')
                   .body(Schema.object.property('a', Schema.string.describe('A')))
        tool.body(tool.body_schema.without('a').property('b', Schema.string.describe('B')))

        assert_equal(
          { 'properties' => { 'b' => { 'description' => 'B', 'type' => 'string' } }, 'required' => ['b'], 'type' => 'object' },
          tool.to_json['api_schema']['request_body_schema'],
        )
      end

      def test_reports_every_problem_at_once_with_paths
        issues = codes_and_paths_of do
          Tool.webhook('broken', 'Broken').get('https://api.example.com/{a}')
              .path_param('b', Schema.string.describe('B').from_variable('b')).build
        end

        assert_equal [
          %w[missing_path_param path_params.a],
          %w[unknown_path_param path_params.b],
          %w[conflicting_value_source path_params.b],
        ], issues
      end

      def test_names_the_tool_and_lists_the_problems_in_the_error_message
        error = assert_raises(ToolValidationError) { Tool.webhook('broken', 'Broken').build }

        assert_equal "Invalid tool \"broken\":\n  - Set the method and URL with get, post, put, patch or delete", error.message
      end

      def test_needs_a_value_source_on_every_literal_in_the_response_and_under_any_container
        issues = codes_and_paths_of do
          Tool.webhook('save', 'Save').post('https://api.example.com/save')
              .query_param('q', Schema.string)
              .body(Schema.object.property('profile', Schema.object.from_variable('profile').property('name', Schema.string)))
              .response(Schema.object.property('status', Schema.string))
              .build
        end

        assert_equal [
          %w[missing_value_source query.q],
          %w[missing_value_source body.profile.name],
          %w[missing_value_source response.status],
        ], issues
      end

      def test_requires_a_body_on_post_put_and_patch
        codes = %i[post put patch].map { |method| codes_of { Tool.webhook('t', 'T').public_send(method, NOTES_URL).build } }

        assert_equal [['missing_body']] * 3, codes
      end

      def test_accepts_a_body_on_post_put_patch_and_delete
        %i[post put patch delete].each { |method| Tool.webhook('t', 'T').public_send(method, NOTES_URL).body(NOTE_BODY).build }
      end

      def test_allows_delete_without_a_body
        Tool.webhook('t', 'T').delete(NOTES_URL).build
      end

      def test_forbids_a_body_on_get_but_allows_a_content_type
        Tool.webhook('t', 'T').get(NOTES_URL).options(content_type: 'application/json').build

        assert_equal(['body_not_allowed'], codes_of { Tool.webhook('t', 'T').get(NOTES_URL).body(NOTE_BODY).build })
      end

      def test_needs_param_names_unique_across_path_query_and_body
        issues = codes_and_paths_of do
          Tool.webhook('t', 'T').post('https://api.example.com/orders')
              .query_param('id', Schema.string.describe('Id'))
              .body(Schema.object.property('id', Schema.string.describe('Id')))
              .build
        end

        assert_equal [%w[duplicate_param body.id]], issues
      end

      def test_accepts_response_timeouts_from_5_to_300_seconds
        [5, 300].each { |secs| get_order.options(response_timeout_secs: secs).build }

        assert_equal([['invalid_option']] * 2,
                     [4, 301].map { |secs| codes_of { get_order.options(response_timeout_secs: secs).build } })
      end

      def test_follows_redirects_only_to_an_allowed_list_of_domains
        get_order.options(follow_redirects: true, follow_redirects_allowed_domains: ['example.com']).build

        assert_equal(['invalid_option'], codes_of { get_order.options(follow_redirects: true).build })
      end

      def test_switches_a_loaded_params_value_source_by_replacing_the_property_in_place
        saved = Tool.webhook('refund', 'Refund').post('https://api.example.com/refunds')
                    .body(Schema.object.property('order_id', Schema.string.describe('The order number'))
                                .property('reason', Schema.string.describe('Why')))
        loaded = Tool.from_json(saved.to_json).as_webhook
        loaded.body(loaded.body_schema.property('order_id', Schema.string.from_variable('order_id')))

        assert_equal(
          {
            'properties' => {
              'order_id' => { 'dynamic_variable' => 'order_id', 'type' => 'string' },
              'reason' => { 'description' => 'Why', 'type' => 'string' },
            },
            'required' => %w[order_id reason],
            'type' => 'object',
          },
          loaded.to_json['api_schema']['request_body_schema'],
        )
      end
    end
  end
end
