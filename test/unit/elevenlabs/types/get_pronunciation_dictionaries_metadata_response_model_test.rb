# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetPronunciationDictionariesMetadataResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'pronunciation_dictionaries' => [{ 'id' => 'test-value', 'latest_version_id' => 'test-value', 'latest_version_rules_num' => 1, 'name' => 'test-value', 'permission_on_resource' => 'admin', 'created_by' => 'test-value', 'creation_time_unix' => 1, 'archived_time_unix' => 1, 'description' => 'test-value' }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::GetPronunciationDictionariesMetadataResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
