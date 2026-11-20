# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreateSoundEffectRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'text' => 'test-value', 'loop' => true, 'duration_seconds' => 1, 'prompt_influence' => 1, 'model_id' => 'eleven_text_to_sound_v2' }

    instance = ::Elevenlabs::TextToSoundEffects::Types::CreateSoundEffectRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
