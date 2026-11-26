# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdateEnvironmentVariableRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'values' => { 'key' => 'test-value' } }

    instance = ::Elevenlabs::EnvironmentVariables::Types::UpdateEnvironmentVariableRequest.new(wire)

    assert_equal(wire, instance.to_h.except('env_var_id'))
  end
end
