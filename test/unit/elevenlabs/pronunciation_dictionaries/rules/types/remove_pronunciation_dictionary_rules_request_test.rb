# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RemovePronunciationDictionaryRulesRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'rule_strings' => ['test-value'] }

    instance = ::Elevenlabs::PronunciationDictionaries::Rules::Types::RemovePronunciationDictionaryRulesRequest.new(wire)

    assert_equal(wire, instance.to_h.except('pronunciation_dictionary_id'))
  end
end
