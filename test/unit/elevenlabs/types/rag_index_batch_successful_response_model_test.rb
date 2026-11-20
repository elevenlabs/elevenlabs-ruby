# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RagIndexBatchSuccessfulResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'status' => 'success', 'data' => { 'id' => 'test-value', 'model' => 'e5_mistral_7b_instruct', 'status' => 'new', 'progress_percentage' => 1, 'document_model_index_usage' => { 'used_bytes' => 1 } } }

    instance = ::Elevenlabs::Types::RagIndexBatchSuccessfulResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
