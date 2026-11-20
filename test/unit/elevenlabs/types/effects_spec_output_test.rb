# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class EffectsSpecOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 }

    instance = ::Elevenlabs::Types::EffectsSpecOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
