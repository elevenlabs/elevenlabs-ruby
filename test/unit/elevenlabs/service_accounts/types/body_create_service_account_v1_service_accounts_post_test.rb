# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateServiceAccountV1ServiceAccountsPostTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'default_sharing_groups' => [{ 'group_id' => 'test-value', 'permission_level' => 'admin' }] }

    instance = ::Elevenlabs::ServiceAccounts::Types::BodyCreateServiceAccountV1ServiceAccountsPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
