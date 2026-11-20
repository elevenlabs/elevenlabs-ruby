# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class InitializeConnectionMultiPronunciationDictionaryLocatorsItemTest < Minitest::Test
  def test_round_trip
    wire = { 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }

    instance = ::Elevenlabs::Types::InitializeConnectionMultiPronunciationDictionaryLocatorsItem.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
