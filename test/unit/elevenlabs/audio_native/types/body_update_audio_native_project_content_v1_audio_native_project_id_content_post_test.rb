# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpdateAudioNativeProjectContentV1AudioNativeProjectIDContentPostTest < Minitest::Test
  def test_round_trip
    wire = { 'file' => 'test-value', 'auto_convert' => true, 'auto_publish' => true }

    instance = ::Elevenlabs::AudioNative::Types::BodyUpdateAudioNativeProjectContentV1AudioNativeProjectIDContentPost.new(wire)

    assert_equal(wire, instance.to_h.except('project_id'))
  end
end
