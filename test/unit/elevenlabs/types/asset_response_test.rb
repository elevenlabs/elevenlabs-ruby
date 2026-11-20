# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AssetResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'asset_id' => 'test-value', 'name' => 'test-value', 'mime_type' => 'test-value', 'created_at_unix' => 1, 'content_url' => 'test-value' }

    instance = ::Elevenlabs::Types::AssetResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
