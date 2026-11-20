# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AssetListResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'assets' => [{ 'asset_id' => 'test-value', 'name' => 'test-value', 'mime_type' => 'test-value', 'created_at_unix' => 1, 'content_url' => 'test-value' }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::AssetListResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
