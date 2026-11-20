# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PronunciationDictionaryVersionResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'version_id' => 'test-value', 'version_rules_num' => 1, 'pronunciation_dictionary_id' => 'test-value', 'dictionary_name' => 'test-value', 'version_name' => 'test-value', 'permission_on_resource' => 'admin', 'created_by' => 'test-value', 'creation_time_unix' => 1, 'archived_time_unix' => 1 }

    instance = ::Elevenlabs::Types::PronunciationDictionaryVersionResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
