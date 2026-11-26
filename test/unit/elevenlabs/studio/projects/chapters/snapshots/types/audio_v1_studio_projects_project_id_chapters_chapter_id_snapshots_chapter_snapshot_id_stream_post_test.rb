# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyStreamChapterAudioV1StudioProjectsProjectIDChaptersChapterIDSnapshotsChapterSnapshotIDStreamPostTest < Minitest::Test
  def test_round_trip
    wire = { 'convert_to_mpeg' => true }

    instance = ::Elevenlabs::Studio::Projects::Chapters::Snapshots::Types::BodyStreamChapterAudioV1StudioProjectsProjectIDChaptersChapterIDSnapshotsChapterSnapshotIDStreamPost.new(wire)

    assert_equal(wire, instance.to_h.except('project_id', 'chapter_id', 'chapter_snapshot_id'))
  end
end
