# frozen_string_literal: true

require 'json'
require 'fileutils'
require_relative 'errors'
require_relative 'format'

module Elevenlabs
  module AgentBuilder
    # File access for AgentProject: reading a project directory and writing the files push and pull changed.
    module ProjectFiles
      AGENTS_FILE = 'agents.json'
      TOOLS_FILE = 'tools.json'
      AGENT_CONFIGS_DIR = 'agent_configs'
      TOOL_CONFIGS_DIR = 'tool_configs'

      module_function

      # Reads the index files and every config they list. Also returns the files already in the config
      # directories, which new files mustn't overwrite.
      def read_project(dir)
        root = ::File.realpath(dir.to_s)
        files = {}
        [AGENTS_FILE, TOOLS_FILE].each do |index|
          text = read_if_exists(resolve_in_project(root, index))
          next if text.nil?

          files[index] = text
          parsed = begin
            ::JSON.parse(text)
          rescue ::JSON::ParserError
            next # AgentProject reports it, with the parse error.
          end
          next unless parsed.is_a?(::Hash)

          config_paths(parsed).each do |config|
            raise AgentProjectError, "#{index} has an entry without a \"config\" path" unless config.is_a?(::String)

            content = read_if_exists(resolve_in_project(root, config))
            files[ProjectFormat.normalize_path(config)] = content unless content.nil?
          end
        end
        taken = [AGENT_CONFIGS_DIR, TOOL_CONFIGS_DIR].flat_map do |sub|
          ::Dir.children(::File.join(root, sub)).map { |name| "#{sub}/#{name}" }
        rescue SystemCallError
          [] # No directory yet.
        end
        [files, taken]
      end

      # Writes each [path, text] pair owner-only (0600), creating directories as needed, never through a
      # symlink or outside the project.
      def write_project_files(dir, files)
        root = ::File.realpath(dir.to_s)
        files.each do |path, text|
          target = resolve_in_project(root, path)
          ::FileUtils.mkdir_p(::File.dirname(target))
          # The directories may only now exist, so check again that none of them leads out of the project.
          resolve_in_project(root, path)
          raise AgentProjectError, "Refusing to write #{path}: it's a symlink" if ::File.symlink?(target)

          flags = ::File::WRONLY | ::File::CREAT | ::File::TRUNC
          flags |= ::File::NOFOLLOW if defined?(::File::NOFOLLOW)
          begin
            ::File.open(target, flags, 0o600) do |file|
              file.chmod(0o600)
              file.write(text.to_s.encode('UTF-8'))
            end
          rescue Errno::ELOOP
            raise AgentProjectError, "Refusing to write #{path}: it's a symlink"
          end
        end
      end

      # The CLI's resolve_in_project: the absolute path for a project-relative one, refusing anything that
      # escapes the project, including through a symlinked directory.
      def resolve_in_project(root, path)
        raise AgentProjectError, "Invalid config path #{::JSON.generate(path.to_s)}" if path.to_s.strip.empty? || path.to_s.match?(/[[:cntrl:]]/)

        candidate = ::File.expand_path(path.to_s, root)
        raise AgentProjectError, "Config path #{path} is outside the project" unless inside?(root, candidate)
        # With symlinks resolved, as far as the path exists, it must still be inside.
        raise AgentProjectError, "Config path #{path} leads outside the project through a symlink" unless inside?(root, real_path(candidate))

        candidate
      end

      # +path+ with symlinks resolved for the part of it that exists.
      def real_path(path)
        missing = []
        current = path
        until ::File.exist?(current) || ::File.symlink?(current)
          parent = ::File.dirname(current)
          return path if parent == current

          missing.unshift(::File.basename(current))
          current = parent
        end
        resolved = begin
          ::File.realpath(current)
        rescue SystemCallError
          # A dangling symlink: where it points.
          ::File.expand_path(::File.readlink(current), ::File.dirname(current))
        end
        missing.empty? ? resolved : ::File.join(resolved, *missing)
      end

      def inside?(root, path)
        path == root || path.start_with?("#{root.chomp(::File::SEPARATOR)}#{::File::SEPARATOR}")
      end

      def read_if_exists(path)
        # Binary read, then UTF-8: line endings are kept, so an untouched file is given back byte for byte.
        ::File.binread(path).force_encoding('UTF-8')
      rescue Errno::ENOENT
        nil
      end

      def config_paths(index)
        agents = index['agents'].is_a?(::Array) ? index['agents'].grep(::Hash) : []
        tools = index['tools'].is_a?(::Array) ? index['tools'].grep(::Hash) : []
        agents.flat_map do |entry|
          branches = entry['branches'].is_a?(::Hash) ? entry['branches'].values : []
          [entry['config']] + branches.map { |branch| branch.is_a?(::Hash) ? branch['config'] : nil }
        end + tools.map { |entry| entry['config'] }
      end
    end
  end
end
