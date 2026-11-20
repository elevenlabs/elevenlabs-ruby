# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AudioOutputMultiTest < Minitest::Test
  def test_round_trip
    wire = { 'audio' => 'test-value', 'is_final' => true, 'normalized_alignment' => { 'chars' => ['test-value'], 'char_start_times_ms' => [1], 'char_durations_ms' => [1] }, 'alignment' => { 'chars' => ['test-value'], 'char_start_times_ms' => [1], 'char_durations_ms' => [1] }, 'context_id' => 'test-value' }

    instance = ::Elevenlabs::Types::AudioOutputMulti.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
