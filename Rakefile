# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'minitest/test_task'

Minitest::TestTask.create do |task|
  # Minitest inlines one require per test into a single `ruby -e` argument. Expand the full-suite
  # globs at runtime to stay below Linux's per-argument limit without changing its helper tasks.
  def task.make_test_cmd(globs = nil)
    return super unless globs.nil?

    original_framework = framework
    patterns = test_globs.map(&:dump).join(', ')
    self.framework = [
      framework,
      "Dir[#{patterns}].uniq.sort.shuffle.each { |file| require File.expand_path(file) }",
    ].join('; ')
    begin
      super([])
    ensure
      self.framework = original_framework
    end
  end
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[test]

task lint: %i[rubocop]
