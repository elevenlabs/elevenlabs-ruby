# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ManualVerificationResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'extra_text' => 'test-value', 'request_time_unix' => 1, 'files' => [{ 'file_id' => 'test-value', 'file_name' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1 }] }

    instance = ::Elevenlabs::Types::ManualVerificationResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
