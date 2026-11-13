# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Analytics
      class Client
        def initialize(client:)
          @client = client
        end

        def live_count
          @live_count ||= LiveCount::Client.new(client: @client)
        end
      end
    end
  end
end
