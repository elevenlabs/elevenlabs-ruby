# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WhatsAppTemplateButtonComponentParamsTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'button', 'parameters' => [{ 'parameter_name' => 'test-value', 'type' => 'text', 'text' => 'test-value' }], 'index' => 1, 'sub_type' => 'test-value' }

    instance = ::Elevenlabs::Types::WhatsAppTemplateButtonComponentParams.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
