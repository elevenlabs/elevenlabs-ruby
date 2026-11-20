# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReviewResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'review_status' => 'approved', 'reviewed_at_unix' => 1, 'reviewed_by' => 'test-value', 'reject_reasons' => ['lacks_structure'], 'scores_breakdown' => { 'key' => 1 }, 'rejected_details' => 'test-value', 'explanation' => 'test-value' }

    instance = ::Elevenlabs::Types::ReviewResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
