# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class MultichannelSpeechToTextResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'transcripts' => [{ 'language_code' => 'test-value', 'language_probability' => 1, 'text' => 'test-value', 'words' => [{ 'text' => 'test-value', 'start' => 1, 'end' => 1, 'type' => 'word', 'speaker_id' => 'test-value', 'logprob' => 1, 'characters' => [{ 'text' => 'test-value', 'start' => 1, 'end' => 1 }], 'channel_index' => 1 }], 'channel_index' => 1, 'additional_formats' => [{ 'requested_format' => 'test-value', 'file_extension' => 'test-value', 'content_type' => 'test-value', 'is_base64_encoded' => true, 'content' => 'test-value' }], 'transcription_id' => 'test-value', 'entities' => [{ 'text' => 'test-value', 'entity_type' => 'test-value', 'start_char' => 1, 'end_char' => 1 }], 'audio_duration_secs' => 1, 'edited_transcript' => { 'kind' => 'transcript', 'text' => 'test-value', 'edited_text' => 'test-value' } }], 'transcription_id' => 'test-value', 'audio_duration_secs' => 1 }

    instance = ::Elevenlabs::Types::MultichannelSpeechToTextResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
