# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VerifiedVoiceLanguageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'language' => 'test-value', 'model_id' => 'test-value', 'accent' => 'test-value', 'locale' => 'test-value', 'preview_url' => 'test-value' }

    instance = ::Elevenlabs::Types::VerifiedVoiceLanguageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
