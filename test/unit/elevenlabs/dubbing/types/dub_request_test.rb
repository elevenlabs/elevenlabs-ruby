# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DubRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'file' => 'test-value', 'csv_file' => 'test-value', 'foreground_audio_file' => 'test-value', 'background_audio_file' => 'test-value', 'name' => 'test-value', 'source_url' => 'test-value', 'source_lang' => 'test-value', 'target_lang' => 'test-value', 'target_accent' => 'test-value', 'num_speakers' => 1, 'watermark' => true, 'start_time' => 1, 'end_time' => 1, 'highest_resolution' => true, 'drop_background_audio' => true, 'use_profanity_filter' => true, 'dubbing_studio' => true, 'disable_voice_cloning' => true, 'mode' => 'automatic', 'csv_fps' => 1 }

    instance = ::Elevenlabs::Dubbing::Types::DubRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
