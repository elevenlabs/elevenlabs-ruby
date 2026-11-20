# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class HTTPRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'http_method' => 'test-value', 'url' => { 'url_string' => 'test-value', 'scheme' => 'test-value', 'hostname' => 'test-value', 'port' => 1, 'path' => 'test-value', 'query_string' => 'test-value' }, 'user_agent' => 'test-value', 'x_forwarded_for' => ['test-value'] }

    instance = ::Elevenlabs::Types::HTTPRequestModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
