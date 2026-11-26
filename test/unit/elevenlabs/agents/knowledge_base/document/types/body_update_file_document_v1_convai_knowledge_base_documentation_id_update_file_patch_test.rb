# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpdateFileDocumentV1ConvaiKnowledgeBaseDocumentationIDUpdateFilePatchTest < Minitest::Test
  def test_round_trip
    wire = { 'file' => 'test-value' }

    instance = ::Elevenlabs::Agents::KnowledgeBase::Document::Types::BodyUpdateFileDocumentV1ConvaiKnowledgeBaseDocumentationIDUpdateFilePatch.new(wire)

    assert_equal(wire, instance.to_h.except('documentation_id'))
  end
end
