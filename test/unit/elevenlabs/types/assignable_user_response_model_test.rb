# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AssignableUserResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'user_id' => 'test-value', 'email' => 'test-value', 'first_name' => 'test-value', 'is_service_account' => true, 'has_access' => true }

    instance = ::Elevenlabs::Types::AssignableUserResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
