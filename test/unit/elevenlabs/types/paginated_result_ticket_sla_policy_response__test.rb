# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PaginatedResultTicketSLAPolicyResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'results' => [{ 'id' => 'test-value', 'name' => 'test-value', 'description' => 'test-value', 'targets' => [{ 'metric' => 'first_response', 'priority' => 'low', 'duration_secs' => 1 }], 'archived' => true, 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1 }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::PaginatedResultTicketSLAPolicyResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
