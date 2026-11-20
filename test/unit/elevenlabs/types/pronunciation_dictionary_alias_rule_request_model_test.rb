# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PronunciationDictionaryAliasRuleRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'string_to_replace' => 'test-value', 'case_sensitive' => true, 'word_boundaries' => true, 'type' => 'alias', 'alias' => 'test-value' }

    instance = ::Elevenlabs::Types::PronunciationDictionaryAliasRuleRequestModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
