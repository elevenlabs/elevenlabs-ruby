# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DubbingBulkTargetSegmentUpdateRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'segments' => { 'key' => { 'translation' => 'test-value' } } }

    instance = ::Elevenlabs::Dubbing::Project::Language::Transcript::Types::DubbingBulkTargetSegmentUpdateRequest.new(wire)

    assert_equal(wire, instance.to_h.except('project_id', 'language_id'))
  end
end
