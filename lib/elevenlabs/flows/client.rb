# frozen_string_literal: true

module Elevenlabs
  module Flows
    class Client
      def initialize(client:)
        @client = client
      end

      def video
        @video ||= Video::Client.new(client: @client)
      end

      def image
        @image ||= Image::Client.new(client: @client)
      end

      def text_to_speech
        @text_to_speech ||= TextToSpeech::Client.new(client: @client)
      end

      def templates
        @templates ||= Templates::Client.new(client: @client)
      end
    end
  end
end
