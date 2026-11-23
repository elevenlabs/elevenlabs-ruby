# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Samples
      class Client
        def initialize(client:, base_url: nil, environment: nil)
          @client = client
          @base_url = base_url
          @environment = environment
        end

        def audio
          @audio ||= Audio::Client.new(client: @client, base_url: @base_url, environment: @environment)
        end
      end
    end
  end
end
