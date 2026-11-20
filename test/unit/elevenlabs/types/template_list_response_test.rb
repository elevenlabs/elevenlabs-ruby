# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TemplateListResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'templates' => [{ 'id' => 'test-value', 'name' => 'test-value', 'description' => 'test-value', 'versions' => [{ 'version_id' => 'test-value', 'published_at_unix' => 1, 'is_latest' => true, 'inputs' => [{ 'id' => 'test-value', 'content_schema' => { 'title' => 'test-value', 'description' => 'test-value', 'type' => 'string', 'enum' => ['test-value'] } }], 'outputs' => [{ 'id' => 'test-value', 'content_schema' => { 'title' => 'test-value', 'description' => 'test-value', 'type' => 'string', 'enum' => ['test-value'] } }] }], 'has_more_versions' => true }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::TemplateListResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
