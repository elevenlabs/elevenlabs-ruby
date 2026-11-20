# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ProcedureRefResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'procedure_id' => 'test-value', 'version_id' => 'test-value', 'name' => 'test-value', 'type' => 'free_form', 'trigger' => 'test-value', 'referenced_tool_ids' => ['test-value'], 'referenced_kb_ids' => ['test-value'], 'referenced_procedure_ids' => ['test-value'], 'referenced_dynamic_variables' => ['test-value'], 'written_dynamic_variables' => ['test-value'], 'folder_parent_id' => 'test-value' }

    instance = ::Elevenlabs::Types::ProcedureRefResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
