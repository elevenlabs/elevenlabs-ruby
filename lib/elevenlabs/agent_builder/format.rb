# frozen_string_literal: true

require_relative '../agent_tools/wire'

module Elevenlabs
  module AgentBuilder
    # The ElevenLabs CLI's project file format and file naming.
    module ProjectFormat
      UNSAFE = %r{[/\\:*?"<>|]}

      module_function

      # The CLI's file format: 4-space indent, no trailing newline (serde_json's pretty printer, and what
      # the JS SDK's JSON.stringify(value, null, 4) writes).
      def format_index(value)
        AgentTools::ToolWire.json_string(value, '', '    ')
      end

      # Config files: like format_index, with keys sorted at every level, as the CLI writes them.
      def format_config(value)
        format_index(AgentTools::ToolWire.canonical(value))
      end

      # The CLI's sanitize_filename: a filesystem-safe file stem for an agent or tool name.
      def sanitize_filename(name)
        # Unicode whitespace, like JavaScript's trim() and \s, which the reference implementation uses.
        trimmed = name.to_s.gsub(/\A[[:space:]]+|[[:space:]]+\z/, '')
        return 'unnamed' if trimmed.empty?

        sanitized = trimmed.each_char.map { |c| c.match?(UNSAFE) || c.match?(/[[:space:]]/) ? '-' : c }.join
        sanitized = sanitized.gsub('--', '-') while sanitized.include?('--')
        stripped = sanitized.gsub(/\A[.-]+|[.-]+\z/, '')
        return 'unnamed' if stripped.empty?

        result = trimmed.start_with?('.') ? "_#{stripped}" : stripped
        result.each_char.first(100).join
      end

      # The CLI's generate_unique_filename: "<dir>/<name>.json", then "-1", "-2"... while the path is taken.
      def unique_path(dir, name, taken)
        stem = sanitize_filename(name)
        candidate = "#{dir}/#{stem}.json"
        n = 1
        while taken.include?(candidate)
          candidate = "#{dir}/#{stem}-#{n}.json"
          n += 1
        end
        candidate
      end

      # A project-relative path in one canonical spelling: forward slashes, no "./" or empty segments.
      def normalize_path(path)
        path.to_s.tr('\\', '/').split('/').reject { |part| part.empty? || part == '.' }.join('/')
      end
    end
  end
end
