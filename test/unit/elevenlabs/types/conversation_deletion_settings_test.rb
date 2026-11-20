# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationDeletionSettingsTest < Minitest::Test
  def test_round_trip
    wire = { 'deletion_time_unix_secs' => 1, 'deleted_logs_at_time_unix_secs' => 1, 'deleted_audio_at_time_unix_secs' => 1, 'deleted_transcript_at_time_unix_secs' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true }

    instance = ::Elevenlabs::Types::ConversationDeletionSettings.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
