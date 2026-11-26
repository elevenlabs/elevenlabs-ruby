# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpdateStudioProjectContentV1StudioProjectsProjectIDContentPostTest < Minitest::Test
  def test_round_trip
    wire = { 'from_url' => 'test-value', 'from_document' => 'test-value', 'from_content_json' => 'test-value', 'auto_convert' => true }

    instance = ::Elevenlabs::Studio::Projects::Content::Types::BodyUpdateStudioProjectContentV1StudioProjectsProjectIDContentPost.new(wire)

    assert_equal(wire, instance.to_h.except('project_id'))
  end
end
