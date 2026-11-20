# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionProductTest < Minitest::Test
  def test_round_trip
    wire = { 'pricing_mode' => 'fixed', 'intake_questions' => [{ 'id' => 'test-value', 'label' => 'test-value', 'kind' => 'text', 'options' => ['test-value'], 'required' => true, 'is_active' => true }], 'groups' => [{ 'label' => 'test-value', 'rank' => 0 }], 'ungrouped_rank' => 0, 'name' => 'test-value', 'description' => 'test-value', 'price' => 0, 'is_active' => true, 'orderable' => true, 'allowed_fulfillment_types' => ['pickup'], 'location_ids' => ['test-value'], 'stock' => { 'key' => 0 }, 'id' => 'test-value', 'created_at_unix' => 1, 'updated_at_unix' => 1 }

    instance = ::Elevenlabs::Types::ReceptionProduct.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
