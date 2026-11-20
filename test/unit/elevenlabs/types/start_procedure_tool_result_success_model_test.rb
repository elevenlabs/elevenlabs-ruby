# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class StartProcedureToolResultSuccessModelTest < Minitest::Test
  def test_round_trip
    wire = { 'result_type' => 'start_procedure_success', 'status' => 'success', 'procedure_id' => 'test-value', 'procedure_name' => 'test-value', 'procedure_entry_workflow_node' => 'test-value', 'procedure_return_workflow_node' => 'test-value', 'message' => 'test-value' }

    instance = ::Elevenlabs::Types::StartProcedureToolResultSuccessModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
