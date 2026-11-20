# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VoiceDesignRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'voice_description' => 'test-valuetest-value', 'text' => 'test-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-value', 'auto_generate_text' => true, 'loudness' => -1, 'quality' => -1, 'seed' => 0, 'guidance_scale' => 0, 'should_enhance' => true }

    instance = ::Elevenlabs::Types::VoiceDesignRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
