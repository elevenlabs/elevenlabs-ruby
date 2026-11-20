# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentMetadataDbModelTest < Minitest::Test
  def test_round_trip
    wire = { 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1, 'created_from' => 'cli', 'last_updated_from' => 'cli' }

    instance = ::Elevenlabs::Types::AgentMetadataDbModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
