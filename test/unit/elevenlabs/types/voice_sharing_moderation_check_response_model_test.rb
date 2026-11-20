# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VoiceSharingModerationCheckResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'date_checked_unix' => 1, 'name_value' => 'test-value', 'name_check' => true, 'description_value' => 'test-value', 'description_check' => true, 'sample_ids' => ['test-value'], 'sample_checks' => [1], 'captcha_ids' => ['test-value'], 'captcha_checks' => [1] }

    instance = ::Elevenlabs::Types::VoiceSharingModerationCheckResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
