# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TestRunMetadataTest < Minitest::Test
  def test_round_trip
    wire = { 'workspace_id' => 'test-value', 'test_name' => 'test-value', 'ran_by_user_email' => 'test-value', 'test_type' => 'llm' }

    instance = ::Elevenlabs::Types::TestRunMetadata.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
