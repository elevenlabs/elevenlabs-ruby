# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpdateDocumentV1ConvaiKnowledgeBaseDocumentationIDPatchTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'content' => 'test-value', 'enable_auto_sync' => true, 'auto_remove' => true, 'minimum_frequency_days' => 1, 'tighten_only' => true }

    instance = ::Elevenlabs::Agents::KnowledgeBase::Documents::Types::BodyUpdateDocumentV1ConvaiKnowledgeBaseDocumentationIDPatch.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
