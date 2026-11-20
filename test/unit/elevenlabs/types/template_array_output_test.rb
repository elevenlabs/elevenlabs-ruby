# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TemplateArrayOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'status' => 'pending', 'failure_reason' => 'timeout', 'error_message' => 'test-value', 'type' => 'array', 'content' => [{ 'id' => 'test-value', 'status' => 'pending', 'failure_reason' => 'timeout', 'error_message' => 'test-value', 'content_url' => 'test-value', 'content_mime_type' => 'test-value', 'type' => 'image' }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::TemplateArrayOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
