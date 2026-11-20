# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TestsFeatureUsageCommonModelTest < Minitest::Test
  def test_round_trip
    wire = { 'enabled' => true, 'tests_ran_after_last_modification' => true, 'tests_ran_in_last_7_days' => true }

    instance = ::Elevenlabs::Types::TestsFeatureUsageCommonModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
