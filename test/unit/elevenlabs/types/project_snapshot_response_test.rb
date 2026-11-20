# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ProjectSnapshotResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'project_snapshot_id' => 'test-value', 'project_id' => 'test-value', 'created_at_unix' => 1, 'name' => 'test-value', 'audio_upload' => {}, 'zip_upload' => {} }

    instance = ::Elevenlabs::Types::ProjectSnapshotResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
