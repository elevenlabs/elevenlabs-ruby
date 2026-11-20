# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SfxSourceContextTest < Minitest::Test
  def test_round_trip
    wire = { 'source_type' => 'sfx', 'sound_generation_history_item_id' => 'test-value', 'text' => 'test-value', 'generation_config' => {} }

    instance = ::Elevenlabs::Types::SfxSourceContext.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
