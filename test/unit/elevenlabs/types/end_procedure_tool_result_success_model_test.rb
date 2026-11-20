# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class EndProcedureToolResultSuccessModelTest < Minitest::Test
  def test_round_trip
    wire = { 'result_type' => 'end_procedure_success', 'status' => 'success', 'procedure_id' => 'test-value', 'procedure_name' => 'test-value', 'message' => 'test-value' }

    instance = ::Elevenlabs::Types::EndProcedureToolResultSuccessModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
