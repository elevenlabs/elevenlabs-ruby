# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AudioEffectsCatalogResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'filter_presets' => [{ 'filter_preset_id' => 'test-value', 'name' => 'test-value', 'description' => 'test-value' }], 'environments' => [{ 'environment_id' => 'test-value', 'name' => 'test-value', 'description' => 'test-value' }], 'background_noises' => [{ 'background_noise_id' => 'test-value', 'name' => 'test-value', 'description' => 'test-value' }] }

    instance = ::Elevenlabs::Types::AudioEffectsCatalogResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
