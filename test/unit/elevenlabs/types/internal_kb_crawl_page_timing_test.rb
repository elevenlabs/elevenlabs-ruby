# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class InternalKbCrawlPageTimingTest < Minitest::Test
  def test_round_trip
    wire = { 'url' => 'test-value', 'doc_id' => 'test-value', 'read_ms' => 1, 'index_ms' => 1, 'html_len' => 1, 'skipped' => true, 'error' => true }

    instance = ::Elevenlabs::Types::InternalKbCrawlPageTiming.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
