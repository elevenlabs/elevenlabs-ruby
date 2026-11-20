# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AssetTranscriptionDataTest < Minitest::Test
  def test_round_trip
    wire = { 'language_code' => 'test-value', 'text' => 'test-value', 'words' => ['test-value'], 'word_start_times_ms' => [1], 'word_end_times_ms' => [1], 'word_speaker_ids' => ['test-value'] }

    instance = ::Elevenlabs::Types::AssetTranscriptionData.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
