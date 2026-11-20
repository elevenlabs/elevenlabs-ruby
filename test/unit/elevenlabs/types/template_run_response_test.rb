# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TemplateRunResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'template_id' => 'test-value', 'version_id' => 'test-value', 'status' => 'pending', 'outputs' => { 'key' => { 'id' => 'test-value', 'status' => 'pending', 'failure_reason' => 'timeout', 'error_message' => 'test-value', 'content_url' => 'test-value', 'content_mime_type' => 'test-value', 'type' => 'image' } } }

    instance = ::Elevenlabs::Types::TemplateRunResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
