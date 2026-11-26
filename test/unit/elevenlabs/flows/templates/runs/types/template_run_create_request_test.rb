# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TemplateRunCreateRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'inputs' => { 'key' => 'test-value' }, 'version_id' => 'test-value', 'webhook' => { 'type' => 'all' } }

    instance = ::Elevenlabs::Flows::Templates::Runs::Types::TemplateRunCreateRequest.new(wire)

    assert_equal(wire, instance.to_h.except('template_id'))
  end
end
