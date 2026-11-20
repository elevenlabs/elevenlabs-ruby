# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AddVoiceIvcResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'voice_id' => 'test-value', 'requires_verification' => true, 'library_voice_match' => { 'library_voice_id' => 'test-value', 'public_owner_id' => 'test-value' } }

    instance = ::Elevenlabs::Types::AddVoiceIvcResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
