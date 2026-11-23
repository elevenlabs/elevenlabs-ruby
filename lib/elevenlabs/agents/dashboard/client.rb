# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Dashboard
      class Client
        def initialize(client:, base_url: nil, environment: nil)
          @client = client
          @base_url = base_url
          @environment = environment
        end

        def settings
          @settings ||= Settings::Client.new(client: @client, base_url: @base_url, environment: @environment)
        end
      end
    end
  end
end
