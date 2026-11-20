# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class LlmDeprecationConfigModelTest < Minitest::Test
  def test_round_trip
    wire = { 'warning_start_days' => 1, 'fallback_start_days' => 1, 'fallback_complete_days' => 1, 'fallback_start_percentage' => 1, 'fallback_complete_percentage' => 1 }

    instance = ::Elevenlabs::Types::LlmDeprecationConfigModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
