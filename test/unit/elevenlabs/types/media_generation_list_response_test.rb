# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class MediaGenerationListResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'generations' => [{ 'id' => 'test-value', 'status' => 'pending' }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::MediaGenerationListResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
