# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AddURLRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'url' => 'test-value', 'crawl_entire_site' => true }

    instance = ::Elevenlabs::Reception::KnowledgeSources::Types::AddURLRequest.new(wire)

    assert_equal(wire, instance.to_h.except('xi-workspace-id'))
  end
end
