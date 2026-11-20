# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetCrawlJobResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'discovery', 'seed_url' => 'test-value', 'pattern' => 'test-value', 'exclude_patterns' => ['test-value'], 'max_pages' => 1, 'auto_discover' => true, 'status' => 'queued', 'pages_identified' => 1, 'pages_scraped' => 1, 'pages_skipped' => 1, 'pages_failed' => 1, 'root_folder_id' => 'test-value', 'updated_at' => 1, 'id' => 'test-value', 'created_at' => 1 }

    instance = ::Elevenlabs::Types::GetCrawlJobResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
