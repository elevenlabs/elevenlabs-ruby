# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CampaignFollowUpRequestsResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'callbacks' => { 'requested' => 1, 'requested_by_disposition' => { 'key' => 1 }, 'distinct_leads' => 1 }, 'redirects' => { 'requested' => 1, 'requested_by_disposition' => { 'key' => 1 }, 'distinct_leads' => 1 } }

    instance = ::Elevenlabs::Types::CampaignFollowUpRequestsResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
