# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpdateStudioProjectV1StudioProjectsProjectIDPostTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'default_title_voice_id' => 'test-value', 'default_paragraph_voice_id' => 'test-value', 'title' => 'test-value', 'author' => 'test-value', 'isbn_number' => 'test-value', 'volume_normalization' => true }

    instance = ::Elevenlabs::Studio::Projects::Types::BodyUpdateStudioProjectV1StudioProjectsProjectIDPost.new(wire)

    assert_equal(wire, instance.to_h.except('project_id'))
  end
end
