# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class MemoryEntrySearchResultTest < Minitest::Test
  def test_round_trip
    wire = { 'entry_id' => 'test-value', 'version' => 1, 'summary' => 'test-value', 'text' => 'test-value', 'source' => { 'type' => 'conversation', 'conversation_id' => 'test-value' } }

    instance = ::Elevenlabs::Types::MemoryEntrySearchResult.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
