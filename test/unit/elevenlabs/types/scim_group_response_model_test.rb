# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SCIMGroupResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'scim_external_id' => 'test-value', 'display_name' => 'test-value', 'created_at_unix' => 1, 'updated_at_unix' => 1, 'seat_type' => 'workspace_admin' }

    instance = ::Elevenlabs::Types::SCIMGroupResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
