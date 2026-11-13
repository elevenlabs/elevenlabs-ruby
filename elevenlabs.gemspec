# frozen_string_literal: true

require_relative 'lib/elevenlabs/version'
require_relative 'custom.gemspec'

Gem::Specification.new do |spec|
  spec.name    = 'elevenlabs-ruby-sdk'
  spec.version = Elevenlabs::VERSION
  spec.authors = ['Elevenlabs']

  spec.summary = 'This is the documentation for the ElevenLabs API. You can use this API to use our service prog...'
  spec.description = 'This is the documentation for the ElevenLabs API. You can use this API to use our service programmatically, this is done by using your API key. You can find your API key in the dashboard at https://elevenlabs.io/app/settings/api-keys.'
  spec.homepage = 'https://github.com/elevenlabs/elevenlabs'
  spec.license = 'MIT'

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.required_ruby_version = '>= 3.3'

  spec.files         = Dir['lib/**/*', 'README.md', 'LICENSE']
  spec.require_paths = ['lib']

  # websocket-driver frames the WebSocket channels; the SDK supplies the socket and threads
  spec.add_dependency 'websocket-driver', '~> 0.8'
  spec.add_development_dependency 'minitest', '~> 5.16'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.85.1'
  spec.add_development_dependency 'rubocop-ast', '~> 1.49.1'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.39.1'
  spec.add_development_dependency 'rubocop-performance', '~> 1.26.1'
  spec.add_development_dependency 'webmock', '~> 3.19'
  spec.add_development_dependency 'minitest-rg'

  # Load custom gemspec configuration if it exists
  custom_gemspec_file = File.join(__dir__, 'custom.gemspec.rb')
  add_custom_gemspec_data(spec) if File.exist?(custom_gemspec_file)
end
