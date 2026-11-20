# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkspaceAnalyticsQueryResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'columns' => ['test-value'], 'column_types' => ['String'], 'rows' => [['test-value']], 'column_units' => ['ms'] }

    instance = ::Elevenlabs::Types::WorkspaceAnalyticsQueryResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
