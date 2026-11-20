# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class FileInputConfigWorkflowOverrideTest < Minitest::Test
  def test_round_trip
    wire = { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }

    instance = ::Elevenlabs::Types::FileInputConfigWorkflowOverride.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
