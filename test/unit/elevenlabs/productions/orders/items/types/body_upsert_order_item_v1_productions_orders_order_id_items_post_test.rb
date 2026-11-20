# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpsertOrderItemV1ProductionsOrdersOrderIDItemsPostTest < Minitest::Test
  def test_round_trip
    wire = { 'request' => { 'item' => { 'kind' => 'dub', 'media_id' => 'test-value', 'source_language' => 'test-value', 'destination_languages' => ['test-value'], 'include_captions' => true, 'include_source_captions' => true, 'instructions' => 'test-value', 'captions_sdh' => true }, 'item_id' => 'test-value' } }

    instance = ::Elevenlabs::Productions::Orders::Items::Types::BodyUpsertOrderItemV1ProductionsOrdersOrderIDItemsPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
