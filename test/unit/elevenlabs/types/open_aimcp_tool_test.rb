# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class OpenAimcpToolTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'mcp', 'server_label' => 'test-value', 'server_url' => 'test-value', 'authorization' => 'test-value', 'allowed_tools' => ['test-value'], 'require_approval' => 'never' }

    instance = ::Elevenlabs::Types::OpenAimcpTool.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
