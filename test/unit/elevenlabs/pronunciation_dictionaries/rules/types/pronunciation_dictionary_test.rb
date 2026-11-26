# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PronunciationDictionaryTest < Minitest::Test
  def test_round_trip
    wire = { 'rules' => [{ 'string_to_replace' => 'test-value', 'case_sensitive' => true, 'word_boundaries' => true, 'type' => 'alias', 'alias' => 'test-value' }] }

    instance = ::Elevenlabs::PronunciationDictionaries::Rules::Types::PronunciationDictionary.new(wire)

    assert_equal(wire, instance.to_h.except('pronunciation_dictionary_id'))
  end
end
