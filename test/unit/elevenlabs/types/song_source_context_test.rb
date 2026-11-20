# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SongSourceContextTest < Minitest::Test
  def test_round_trip
    wire = { 'source_type' => 'song', 'song_id' => 'test-value', 'chat_id' => 'test-value', 'title' => 'test-value', 'description' => 'test-value', 'genres' => ['test-value'], 'languages' => ['test-value'], 'is_explicit' => true, 'bpm' => 1, 'generation_settings' => {} }

    instance = ::Elevenlabs::Types::SongSourceContext.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
