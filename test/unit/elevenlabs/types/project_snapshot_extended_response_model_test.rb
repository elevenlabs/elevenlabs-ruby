# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ProjectSnapshotExtendedResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'project_snapshot_id' => 'test-value', 'project_id' => 'test-value', 'created_at_unix' => 1, 'name' => 'test-value', 'audio_upload' => {}, 'zip_upload' => {}, 'character_alignments' => [{ 'characters' => ['test-value'], 'character_start_times_seconds' => [1], 'character_end_times_seconds' => [1] }], 'audio_duration_secs' => 1 }

    instance = ::Elevenlabs::Types::ProjectSnapshotExtendedResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
