# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreateCrawlJobResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'type' => 'discovery', 'root_folder_id' => 'test-value', 'status' => 'test-value', 'created_at' => 1, 'folder_path' => [{ 'id' => 'test-value' }] }

    instance = ::Elevenlabs::Types::CreateCrawlJobResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
