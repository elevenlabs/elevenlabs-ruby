# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreatePronunciationDictionariesV1StudioProjectsProjectIDPronunciationDictionariesPostTest < Minitest::Test
  def test_round_trip
    wire = { 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'invalidate_affected_text' => true }

    instance = ::Elevenlabs::Studio::Projects::PronunciationDictionaries::Types::BodyCreatePronunciationDictionariesV1StudioProjectsProjectIDPronunciationDictionariesPost.new(wire)

    assert_equal(wire, instance.to_h.except('project_id'))
  end
end
