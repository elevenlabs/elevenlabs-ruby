# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CharacterMetadataResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'description' => 'test-value', 'sample_message' => 'test-value', 'voice_creation_prompt_suggestion' => 'test-value', 'gender' => 'male', 'age' => 'young', 'accent' => 'test-value', 'role' => 'narrator' }

    instance = ::Elevenlabs::Types::CharacterMetadataResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
