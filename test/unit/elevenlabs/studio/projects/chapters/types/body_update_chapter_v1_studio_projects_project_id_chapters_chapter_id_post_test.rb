# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpdateChapterV1StudioProjectsProjectIDChaptersChapterIDPostTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'content' => { 'blocks' => [{ 'sub_type' => 'p', 'nodes' => [{ 'type' => 'tts_node', 'text' => 'test-value', 'voice_id' => 'test-value' }], 'block_id' => 'test-value' }] } }

    instance = ::Elevenlabs::Studio::Projects::Chapters::Types::BodyUpdateChapterV1StudioProjectsProjectIDChaptersChapterIDPost.new(wire)

    assert_equal(wire, instance.to_h.except('project_id', 'chapter_id'))
  end
end
