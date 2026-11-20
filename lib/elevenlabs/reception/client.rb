# frozen_string_literal: true

module Elevenlabs
  module Reception
    class Client
      def initialize(client:)
        @client = client
      end

      def services
        @services ||= Services::Client.new(client: @client)
      end

      def assets
        @assets ||= Assets::Client.new(client: @client)
      end

      def products
        @products ||= Products::Client.new(client: @client)
      end

      def staff
        @staff ||= Staff::Client.new(client: @client)
      end

      def receptionists
        @receptionists ||= Receptionists::Client.new(client: @client)
      end

      def phone_numbers
        @phone_numbers ||= PhoneNumbers::Client.new(client: @client)
      end

      def holidays
        @holidays ||= Holidays::Client.new(client: @client)
      end

      def locations
        @locations ||= Locations::Client.new(client: @client)
      end

      def business_profile
        @business_profile ||= BusinessProfile::Client.new(client: @client)
      end

      def knowledge_sources
        @knowledge_sources ||= KnowledgeSources::Client.new(client: @client)
      end

      def workspaces
        @workspaces ||= Workspaces::Client.new(client: @client)
      end

      def subscriptions
        @subscriptions ||= Subscriptions::Client.new(client: @client)
      end

      def tiers
        @tiers ||= Tiers::Client.new(client: @client)
      end

      def billing
        @billing ||= Billing::Client.new(client: @client)
      end

      def team
        @team ||= Team::Client.new(client: @client)
      end
    end
  end
end
