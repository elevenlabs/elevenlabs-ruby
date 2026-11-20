# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class StartProcedureToolResultErrorModelTest < Minitest::Test
  def test_round_trip
    wire = { 'result_type' => 'start_procedure_error', 'status' => 'not_found', 'procedure_id' => 'test-value', 'message' => 'test-value' }

    instance = ::Elevenlabs::Types::StartProcedureToolResultErrorModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
