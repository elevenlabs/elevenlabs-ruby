# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CharacterResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'character_id' => 'test-value', 'name' => 'test-value', 'metadata' => { 'description' => 'test-value', 'sample_message' => 'test-value', 'voice_creation_prompt_suggestion' => 'test-value', 'gender' => 'male', 'age' => 'young', 'accent' => 'test-value', 'role' => 'narrator' }, 'recommended_voice_ids' => ['test-value'] }

    instance = ::Elevenlabs::Types::CharacterResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
