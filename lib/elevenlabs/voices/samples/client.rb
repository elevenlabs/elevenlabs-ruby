# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Samples
      class Client
        def initialize(client:)
          @client = client
        end

        def audio
          @audio ||= Audio::Client.new(client: @client)
        end
      end
    end
  end
end
