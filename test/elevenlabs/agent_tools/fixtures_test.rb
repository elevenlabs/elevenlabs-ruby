# frozen_string_literal: true

require 'minitest/autorun'
require 'json'
require_relative 'fixture_runner'

module Elevenlabs
  module AgentTools
    # Shared golden fixtures. Every SDK runs the same files, copied from the reference SDK (elevenlabs-js,
    # docs/agents-as-code/fixtures/tools); `expected` is produced there, never here.
    class FixturesTest < Minitest::Test
      FIXTURE_DIR = File.join(__dir__, 'fixtures')
      FILES = Dir[File.join(FIXTURE_DIR, '*.json')].freeze

      def test_there_are_fixtures
        assert_operator FILES.length, :>=, 21
      end

      FILES.each do |path|
        name = File.basename(path, '.json').gsub(/[^a-z0-9]+/i, '_')
        define_method("test_fixture_#{name}") do
          fixture = ::JSON.parse(File.read(path))
          result = FixtureRunner.run_fixture(fixture)

          if fixture.key?('errors')
            assert_equal fixture['errors'].sort, (result[:errors] || []).sort,
                         "#{File.basename(path)}: error codes"
          else
            refute result.key?(:errors), "#{File.basename(path)}: unexpected errors #{result[:errors].inspect}"
            expected = "#{::JSON.pretty_generate(fixture['expected'])}\n"

            assert_equal expected, result[:json], "#{File.basename(path)}: canonical JSON"
          end
        end
      end
    end
  end
end
