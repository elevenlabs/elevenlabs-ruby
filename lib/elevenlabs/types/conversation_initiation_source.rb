# frozen_string_literal: true

module Elevenlabs
  module Types
    module ConversationInitiationSource
      extend ::Elevenlabs::Internal::Types::Enum

      UNKNOWN = :unknown
      ANDROID_SDK = :android_sdk
      NODE_JS_SDK = :node_js_sdk
      REACT_NATIVE_SDK = :react_native_sdk
      REACT_SDK = :react_sdk
      JS_SDK = :js_sdk
      PYTHON_SDK = :python_sdk
      WIDGET = :widget
      SIP_TRUNK = :sip_trunk
      TWILIO = :twilio
      EXOTEL = :exotel
      GENESYS = :genesys
      AVAYA = :avaya
      AUDIOCODES = :audiocodes
      SWIFT_SDK = :swift_sdk
      WHATSAPP = :whatsapp
      TWILIO_SMS = :twilio_sms
      FLUTTER_SDK = :flutter_sdk
      ZENDESK_INTEGRATION = :zendesk_integration
      SLACK_INTEGRATION = :slack_integration
      TELEGRAM_INTEGRATION = :telegram_integration
      INTERCOM_INTEGRATION = :intercom_integration
      FRESHDESK_INTEGRATION = :freshdesk_integration
      SALESFORCE_INTEGRATION = :salesforce_integration
      TEMPLATE_PREVIEW = :template_preview
      GENESYS_BOT_CONNECTOR = :genesys_bot_connector
      SUBAGENT_TOOL = :subagent_tool

      def self.load(str)
        coerce(::JSON.parse(str, symbolize_names: true))
      end

      def self.dump(value)
        coerced = coerce(value)
        ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
      end
    end
  end
end
