# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SpeechHistoryItemResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'history_item_id' => 'test-value', 'request_id' => 'test-value', 'voice_id' => 'test-value', 'model_id' => 'test-value', 'voice_name' => 'test-value', 'voice_category' => 'premade', 'text' => 'test-value', 'date_unix' => 1, 'character_count_change_from' => 1, 'character_count_change_to' => 1, 'content_type' => 'test-value', 'state' => {}, 'settings' => {}, 'share_link_id' => 'test-value', 'source' => 'TTS', 'alignments' => { 'alignment' => { 'characters' => ['test-value'], 'character_start_times_seconds' => [1], 'character_end_times_seconds' => [1] }, 'normalized_alignment' => { 'characters' => ['test-value'], 'character_start_times_seconds' => [1], 'character_end_times_seconds' => [1] } }, 'dialogue' => [{ 'text' => 'test-value', 'voice_id' => 'test-value', 'voice_name' => 'test-value' }], 'output_format' => 'test-value' }

    instance = ::Elevenlabs::Types::SpeechHistoryItemResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
