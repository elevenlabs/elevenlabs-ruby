# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VerificationAttemptResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'text' => 'test-value', 'date_unix' => 1, 'accepted' => true, 'similarity' => 1, 'levenshtein_distance' => 1, 'recording' => { 'recording_id' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1, 'transcription' => 'test-value' } }

    instance = ::Elevenlabs::Types::VerificationAttemptResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
