# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class MessagesSearchResultTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_id' => 'test-value', 'agent_id' => 'test-value', 'agent_name' => 'test-value', 'transcript_index' => 1, 'chunk_text' => 'test-value', 'chunk_highlights' => [{ 'value' => 'test-value', 'is_hit' => true }], 'score' => 1, 'conversation_start_time_unix_secs' => 1 }

    instance = ::Elevenlabs::Types::MessagesSearchResult.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
