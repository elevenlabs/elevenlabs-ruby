# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CampaignProgressResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'leads' => { 'total' => 1, 'uncalled' => 1, 'leads_needing_attention' => 1, 'active' => 1, 'finished' => 1, 'finished_by_disposition' => { 'key' => 1 } }, 'conversations' => { 'scheduled' => 1, 'scheduled_by_type' => { 'key' => 1 }, 'awaiting_permission' => 1, 'in_progress' => 1, 'awaiting_analysis' => 1 }, 'next_call_time_unix' => 1 }

    instance = ::Elevenlabs::Types::CampaignProgressResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
