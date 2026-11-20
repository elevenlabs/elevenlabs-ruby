# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ChapterStatisticsResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'characters_unconverted' => 1, 'characters_converted' => 1, 'paragraphs_converted' => 1, 'paragraphs_unconverted' => 1, 'credits_needed_to_convert' => 1, 'voice_statistics' => [{ 'project_voice_ref_id' => 'test-value', 'characters_unconverted' => 1, 'characters_converted' => 1, 'credits_needed_to_convert' => 1, 'voice_id' => 'test-value' }] }

    instance = ::Elevenlabs::Types::ChapterStatisticsResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
