# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SubscriptionResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'tier' => 'test-value', 'character_count' => 1, 'character_limit' => 1, 'max_character_limit_extension' => 1, 'max_credit_limit_extension' => 1, 'can_extend_character_limit' => true, 'allowed_to_extend_character_limit' => true, 'next_character_count_reset_unix' => 1, 'voice_slots_used' => 1, 'professional_voice_slots_used' => 1, 'professional_voice_slots_used_in_workspace' => 1, 'voice_limit' => 1, 'max_voice_add_edits' => 1, 'voice_add_edit_counter' => 1, 'professional_voice_limit' => 1, 'can_extend_voice_limit' => true, 'can_use_instant_voice_cloning' => true, 'can_use_professional_voice_cloning' => true, 'currency' => 'usd', 'current_overage' => { 'amount' => 'test-value', 'currency' => 'usd' }, 'status' => 'trialing', 'billing_period' => 'monthly_period', 'character_refresh_period' => 'monthly_period' }

    instance = ::Elevenlabs::Types::SubscriptionResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
