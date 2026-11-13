# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Dashboard
      class Client
        def initialize(client:)
          @client = client
        end

        def settings
          @settings ||= Settings::Client.new(client: @client)
        end
      end
    end
  end
end
