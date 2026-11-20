# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GenerationSourceContextTest < Minitest::Test
  def test_round_trip
    wire = { 'source_type' => 'generation', 'generation_id' => 'test-value', 'prompt' => 'test-value', 'model_id' => 'test-value', 'model_provider' => 'test-value', 'generation_session_id' => 'test-value', 'session_iteration_id' => 'test-value', 'model_parameters' => {}, 'extend_video' => { 'generation_id' => 'test-value', 'content_asset_id' => 'test-value', 'template_node_id' => 'test-value', 'studio_clip' => { 'project_id' => 'test-value', 'chapter_id' => 'test-value', 'clip_type' => 'video', 'clip_id' => 'test-value', 'block_id' => 'test-value', 'preview_url' => 'test-value' } } }

    instance = ::Elevenlabs::Types::GenerationSourceContext.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
