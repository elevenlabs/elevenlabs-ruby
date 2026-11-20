# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PlainPlatformMetadataTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_initiation_source' => 'plain_integration', 'thread_id' => 'test-value', 'workspace_id' => 'test-value' }

    instance = ::Elevenlabs::Types::PlainPlatformMetadata.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
