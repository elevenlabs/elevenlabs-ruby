# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ProjectImageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'image_id' => 'test-value', 'filename' => 'test-value', 'signed_url' => 'test-value', 'thumbnail_signed_url' => 'test-value', 'type' => 'image', 'source' => 'upload', 'file_size_bytes' => 1, 'width' => 1, 'height' => 1, 'track_id' => 'test-value', 'offset_ms' => 1, 'duration_ms' => 1, 'order' => 'test-value', 'canvas_placement' => { 'x_relative' => 1, 'y_relative' => 1, 'scale_x' => 1, 'scale_y' => 1, 'pivot_x' => 1, 'pivot_y' => 1, 'skew_x' => 1, 'skew_y' => 1, 'crop_top' => 1, 'crop_right' => 1, 'crop_bottom' => 1, 'crop_left' => 1, 'flip_x' => true, 'flip_y' => true }, 'animation' => { 'enter_effect' => 'none', 'enter_duration_ms' => 1, 'exit_effect' => 'none', 'exit_duration_ms' => 1 }, 'opacity' => 0, 'created_at_ms' => 1, 'updated_at_ms' => 1, 'current_snapshot_id' => 'test-value', 'source_asset_id' => 'test-value', 'source_platform_asset_id' => 'test-value', 'error' => 'test-value', 'pending_task' => { 'type' => 'preprocessing', 'progress' => 1, 'started_at_ms' => 1, 'updated_at_ms' => 1, 'metadata' => {} }, 'analysis' => { 'status' => 'processing', 'data' => { 'title' => 'test-value', 'description' => 'test-value', 'content_type' => 'test-value', 'mood_and_style' => 'test-value', 'composition_notes' => 'test-value', 'visible_text' => 'test-value', 'subjects' => [{ 'name' => 'test-value', 'description' => 'test-value' }] }, 'updated_at_ms' => 1 } }

    instance = ::Elevenlabs::Types::ProjectImageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
