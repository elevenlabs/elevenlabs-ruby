# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateDubbingProjectV1DubbingProjectPostTest < Minitest::Test
  def test_round_trip
    wire = { 'file' => 'test-value', 'source_url' => 'test-value', 'reference' => 'test-value', 'source_language' => 'test-value', 'model_id' => 'dubbing_v1', 'keyterms' => ['test-value'], 'webhook_ids' => ['test-value'], 'target_language' => 'test-value', 'transcript' => 'test-value' }

    instance = ::Elevenlabs::Dubbing::Project::Types::BodyCreateDubbingProjectV1DubbingProjectPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
