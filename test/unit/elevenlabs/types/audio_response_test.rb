# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AudioResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'audio_event' => { 'audio_base_64' => 'test-value', 'event_id' => 1, 'alignment' => { 'chars' => ['test-value'], 'char_start_times_ms' => [1], 'char_durations_ms' => [1] }, 'is_final' => true }, 'type' => 'audio' }

    instance = ::Elevenlabs::Types::AudioResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
