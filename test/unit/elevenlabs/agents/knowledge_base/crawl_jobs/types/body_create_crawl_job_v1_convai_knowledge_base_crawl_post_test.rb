# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateCrawlJobV1ConvaiKnowledgeBaseCrawlPostTest < Minitest::Test
  def test_round_trip
    wire = { 'url' => 'test-value', 'max_depth' => 1, 'max_pages' => 1, 'pattern' => 'test-value', 'exclude_patterns' => ['test-value'], 'sitemap_urls' => ['test-value'], 'parent_folder_id' => 'test-value', 'enable_auto_sync' => true, 'auto_remove' => true, 'auto_discover' => true, 'minimum_frequency_days' => 1 }

    instance = ::Elevenlabs::Agents::KnowledgeBase::CrawlJobs::Types::BodyCreateCrawlJobV1ConvaiKnowledgeBaseCrawlPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
