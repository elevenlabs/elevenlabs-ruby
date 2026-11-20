# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyRegisterMediaV1ProductionsOrdersOrderIDMediaPostTest < Minitest::Test
  def test_round_trip
    wire = { 'declared_language' => 'test-value', 'media' => 'test-value', 'media_url' => 'test-value', 'media_url_filename' => 'test-value', 'media_url_content_type' => 'test-value' }

    instance = ::Elevenlabs::Productions::Orders::Media::Types::BodyRegisterMediaV1ProductionsOrdersOrderIDMediaPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
