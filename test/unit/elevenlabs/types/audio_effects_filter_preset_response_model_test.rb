# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AudioEffectsFilterPresetResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'filter_preset_id' => 'test-value', 'name' => 'test-value', 'description' => 'test-value' }

    instance = ::Elevenlabs::Types::AudioEffectsFilterPresetResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
