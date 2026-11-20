# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AssetTranscriptionTest < Minitest::Test
  def test_round_trip
    wire = { 'status' => 'processing', 'data' => { 'language_code' => 'test-value', 'text' => 'test-value', 'words' => ['test-value'], 'word_start_times_ms' => [1], 'word_end_times_ms' => [1], 'word_speaker_ids' => ['test-value'] }, 'updated_at_ms' => 1 }

    instance = ::Elevenlabs::Types::AssetTranscription.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
