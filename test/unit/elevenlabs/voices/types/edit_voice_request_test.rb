# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class EditVoiceRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'files' => ['test-value'], 'remove_background_noise' => true, 'description' => 'test-value', 'labels' => { 'key' => 'test-value' }, 'moderate_metadata' => true }

    instance = ::Elevenlabs::Voices::Types::EditVoiceRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
