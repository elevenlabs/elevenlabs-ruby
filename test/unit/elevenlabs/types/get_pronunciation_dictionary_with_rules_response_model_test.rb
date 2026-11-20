# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetPronunciationDictionaryWithRulesResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'latest_version_id' => 'test-value', 'latest_version_rules_num' => 1, 'name' => 'test-value', 'permission_on_resource' => 'admin', 'created_by' => 'test-value', 'creation_time_unix' => 1, 'archived_time_unix' => 1, 'description' => 'test-value', 'rules' => [{ 'string_to_replace' => 'test-value', 'case_sensitive' => true, 'word_boundaries' => true, 'type' => 'alias', 'alias' => 'test-value' }] }

    instance = ::Elevenlabs::Types::GetPronunciationDictionaryWithRulesResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
