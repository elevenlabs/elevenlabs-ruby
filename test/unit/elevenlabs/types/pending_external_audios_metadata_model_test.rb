# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PendingExternalAudiosMetadataModelTest < Minitest::Test
  def test_round_trip
    wire = { 'target_global_offset_ms' => 1, 'external_audio_ids' => ['test-value'] }

    instance = ::Elevenlabs::Types::PendingExternalAudiosMetadataModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
