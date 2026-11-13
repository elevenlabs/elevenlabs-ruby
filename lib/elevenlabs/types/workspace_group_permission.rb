# frozen_string_literal: true

module Elevenlabs
  module Types
    module WorkspaceGroupPermission
      extend ::Elevenlabs::Internal::Types::Enum

      TEXT_TO_SPEECH = :text_to_speech
      SPEECH_TO_SPEECH = :speech_to_speech
      SPEECH_TO_TEXT = :speech_to_text
      VOICE_LAB = :voice_lab
      SOUND_EFFECTS = :sound_effects
      PROJECTS = :projects
      VOICEOVER_STUDIO = :voiceover_studio
      DUBBING = :dubbing
      AUDIO_NATIVE = :audio_native
      CONVERSATIONAL_AI = :conversational_ai
      CONVERSATIONAL_AI_READ = :conversational_ai_read
      ARCHITECT = :architect
      VOICE_ISOLATOR = :voice_isolator
      AI_SPEECH_CLASSIFIER = :ai_speech_classifier
      SYNTHID_DETECTOR = :synthid_detector
      ADD_VOICE_FROM_VOICE_LIBRARY = :add_voice_from_voice_library
      CREATE_INSTANT_VOICE_CLONE = :create_instant_voice_clone
      CREATE_PROFESSIONAL_VOICE_CLONE = :create_professional_voice_clone
      CREATE_USER_API_KEY = :create_user_api_key
      PUBLISH_STUDIO_PROJECT = :publish_studio_project
      MUSIC = :music
      IMAGE_VIDEO_GENERATION = :image_video_generation
      FLOWS = :flows
      TEMPLATES = :templates
      SHARE_VOICE_EXTERNALLY = :share_voice_externally
      PUBLISH_VOICE_TO_VOICE_LIBRARY = :publish_voice_to_voice_library
      VIEW_FIAT_BALANCE = :view_fiat_balance
      WORKSPACE_ANALYTICS_FULL_READ = :workspace_analytics_full_read
      SERVICE_ACCOUNTS_MANAGE = :service_accounts_manage
      WEBHOOKS_MANAGE = :webhooks_manage
      GROUP_MEMBERS_MANAGE = :group_members_manage
      WORKSPACE_MEMBERS_INVITE = :workspace_members_invite
      WORKSPACE_MEMBERS_REMOVE = :workspace_members_remove
      TERMS_OF_SERVICE_ACCEPT = :terms_of_service_accept
      AUDIT_LOG_READ = :audit_log_read
      CONVERSATION_PRIVACY_MANAGE = :conversation_privacy_manage
      ALL_RESOURCES_ACCESS = :all_resources_access
      COPY_RESOURCES_CROSS_WORKSPACE = :copy_resources_cross_workspace
      VOICE_DESIGN = :voice_design

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
