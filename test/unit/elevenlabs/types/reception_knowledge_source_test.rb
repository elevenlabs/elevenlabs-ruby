# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionKnowledgeSourceTest < Minitest::Test
  def test_round_trip
    wire = { 'source_type' => 'file', 'source_url' => 'test-value', 'last_scraped_at_unix' => 1, 'original_filename' => 'test-value', 'content_type' => 'test-value', 'file_size_bytes' => 1, 'status' => 'processing', 'error_message' => 'test-value', 'failure_reason' => 'blocked_url', 'crawl_entire_site' => true, 'scraped_pages_count' => 1, 'content_preview' => 'test-value', 'processing_started_at_unix' => 1, 'id' => 'test-value', 'created_at_unix' => 1, 'updated_at_unix' => 1 }

    instance = ::Elevenlabs::Types::ReceptionKnowledgeSource.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
