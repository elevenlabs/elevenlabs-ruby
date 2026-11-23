# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Analytics
      class Client
        def initialize(client:, base_url: nil, environment: nil)
          @client = client
          @base_url = base_url
          @environment = environment
        end

        def live_count
          @live_count ||= LiveCount::Client.new(client: @client, base_url: @base_url, environment: @environment)
        end
      end
    end
  end
end
