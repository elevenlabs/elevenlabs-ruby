# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ChapterContentResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'blocks' => [{ 'block_id' => 'test-value', 'nodes' => [{ 'type' => 'tts_node', 'project_voice_ref_id' => 'test-value', 'text' => 'test-value', 'voice_id' => 'test-value' }] }] }

    instance = ::Elevenlabs::Types::ChapterContentResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
