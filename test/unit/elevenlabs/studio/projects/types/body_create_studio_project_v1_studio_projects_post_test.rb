# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateStudioProjectV1StudioProjectsPostTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'default_title_voice_id' => 'test-value', 'default_paragraph_voice_id' => 'test-value', 'default_model_id' => 'test-value', 'from_url' => 'test-value', 'from_document' => 'test-value', 'from_content_json' => 'test-value', 'quality_preset' => 'standard', 'title' => 'test-value', 'author' => 'test-value', 'description' => 'test-value', 'genres' => ['test-value'], 'target_audience' => 'children', 'language' => 'te', 'content_type' => 'test-value', 'original_publication_date' => 'test-value', 'mature_content' => true, 'isbn_number' => 'test-value', 'acx_volume_normalization' => true, 'volume_normalization' => true, 'pronunciation_dictionary_locators' => ['test-value'], 'callback_url' => 'test-value', 'fiction' => 'fiction', 'apply_text_normalization' => 'auto', 'auto_convert' => true, 'auto_assign_voices' => true, 'source_type' => 'blank', 'voice_settings' => ['test-value'], 'create_publishing_read' => true }

    instance = ::Elevenlabs::Studio::Projects::Types::BodyCreateStudioProjectV1StudioProjectsPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
