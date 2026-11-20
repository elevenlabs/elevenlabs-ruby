# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AutoGenerationMetadataTest < Minitest::Test
  def test_round_trip
    wire = { 'agent_id' => 'test-value', 'stable_topic_id' => 'test-value', 'criteria_id' => 'test-value', 'topic_label' => 'test-value', 'source_conversation_id' => 'test-value', 'generated_at_unix' => 1 }

    instance = ::Elevenlabs::Types::AutoGenerationMetadata.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
