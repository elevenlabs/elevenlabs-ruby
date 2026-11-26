# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyAddSamplesToPvcVoiceV1VoicesPvcVoiceIDSamplesPostTest < Minitest::Test
  def test_round_trip
    wire = { 'files' => ['test-value'], 'remove_background_noise' => true }

    instance = ::Elevenlabs::Voices::Pvc::Samples::Types::BodyAddSamplesToPvcVoiceV1VoicesPvcVoiceIDSamplesPost.new(wire)

    assert_equal(wire, instance.to_h.except('voice_id'))
  end
end
