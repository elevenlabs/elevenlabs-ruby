# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetTestInvocationsPageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'meta' => { 'total' => 1, 'page' => 1, 'page_size' => 1 }, 'results' => [{ 'id' => 'test-value', 'name' => 'test-value', 'agent_id' => 'test-value', 'branch_id' => 'test-value', 'version_id' => 'test-value', 'ran_against_draft' => true, 'runs_diverged_from_version' => true, 'created_at_unix_secs' => 1, 'test_run_count' => 1, 'passed_count' => 1, 'failed_count' => 1, 'pending_count' => 1, 'cancelled_count' => 1, 'title' => 'test-value', 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }, 'repeat_count' => 1, 'cancelled' => true, 'credits_used' => 1, 'total_price' => 1 }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::GetTestInvocationsPageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
