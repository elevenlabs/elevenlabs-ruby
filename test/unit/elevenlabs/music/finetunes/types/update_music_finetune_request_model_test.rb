# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdateMusicFinetuneRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'tags' => ['test-value'], 'primary_genre' => 'test-value', 'visibility' => 'private' }

    instance = ::Elevenlabs::Music::Finetunes::Types::UpdateMusicFinetuneRequestModel.new(wire)

    assert_equal(wire, instance.to_h.except('finetune_id'))
  end
end
