# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RagIndexOverviewResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'total_used_bytes' => 1, 'total_max_bytes' => 1, 'models' => [{ 'model' => 'e5_mistral_7b_instruct', 'used_bytes' => 1 }] }

    instance = ::Elevenlabs::Types::RagIndexOverviewResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
