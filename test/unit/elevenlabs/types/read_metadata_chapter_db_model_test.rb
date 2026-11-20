# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReadMetadataChapterDbModelTest < Minitest::Test
  def test_round_trip
    wire = { 'chapter_name' => 'test-value', 'word_count' => 1, 'char_count' => 1, 'starting_char_offset' => 1, 'has_parsed_html' => true, 'has_summary' => true, 'duration_seconds' => 1, 'file_number' => 'test-value', 'is_fallback_name' => true, 'chapter_id' => 'test-value' }

    instance = ::Elevenlabs::Types::ReadMetadataChapterDbModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
