# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ExternalFileSyncInfoTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'google_drive', 'source_entity_id' => 'test-value', 'integration_connection_id' => 'test-value', 'source_parent_entity_id' => 'test-value', 'source_mime_type' => 'test-value', 'source_modified_time' => 'test-value', 'root_folder_id' => 'test-value' }

    instance = ::Elevenlabs::Types::ExternalFileSyncInfo.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
