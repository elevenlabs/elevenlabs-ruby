# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module Analytics
      class Client
        def initialize(client:)
          @client = client
        end

        def requests
          @requests ||= Requests::Client.new(client: @client)
        end
      end
    end
  end
end
