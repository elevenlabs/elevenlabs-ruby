# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class OTelSpanTest < Minitest::Test
  def test_round_trip
    wire = { 'traceId' => 'test-value', 'spanId' => 'test-value', 'parentSpanId' => 'test-value', 'name' => 'test-value', 'kind' => 1, 'startTimeUnixNano' => 'test-value', 'endTimeUnixNano' => 'test-value', 'attributes' => [{ 'key' => 'test-value', 'value' => { 'key' => 'test-value' } }], 'status' => { 'code' => 1, 'message' => 'test-value' } }

    instance = ::Elevenlabs::Types::OTelSpan.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
