# frozen_string_literal: true

module Elevenlabs
  module Types
    module PermissionType
      extend ::Elevenlabs::Internal::Types::Enum

      TEXT_TO_SPEECH = :text_to_speech
      SPEECH_TO_SPEECH = :speech_to_speech
      SPEECH_TO_TEXT = :speech_to_text
      MODELS_READ = :models_read
      MODELS_WRITE = :models_write
      VOICES_READ = :voices_read
      VOICES_WRITE = :voices_write
      VOICE_COLLECTIONS_READ = :voice_collections_read
      VOICE_COLLECTIONS_WRITE = :voice_collections_write
      SPEECH_HISTORY_READ = :speech_history_read
      SPEECH_HISTORY_WRITE = :speech_history_write
      SOUND_GENERATION = :sound_generation
      AUDIO_ISOLATION = :audio_isolation
      VOICE_GENERATION = :voice_generation
      DUBBING_READ = :dubbing_read
      DUBBING_WRITE = :dubbing_write
      PRONUNCIATION_DICTIONARIES_READ = :pronunciation_dictionaries_read
      PRONUNCIATION_DICTIONARIES_WRITE = :pronunciation_dictionaries_write
      USER_READ = :user_read
      USER_WRITE = :user_write
      PROJECTS_READ = :projects_read
      PROJECTS_WRITE = :projects_write
      AUDIO_NATIVE_READ = :audio_native_read
      AUDIO_NATIVE_WRITE = :audio_native_write
      WORKSPACE_READ = :workspace_read
      WORKSPACE_WRITE = :workspace_write
      FORCED_ALIGNMENT = :forced_alignment
      CONVAI_READ = :convai_read
      CONVAI_WRITE = :convai_write
      AGENTS_ARCHITECT = :agents_architect
      MUSIC_GENERATION = :music_generation
      IMAGE_VIDEO_GENERATION = :image_video_generation
      FLOWS = :flows
      TEMPLATES = :templates
      ADD_VOICE_FROM_VOICE_LIBRARY = :add_voice_from_voice_library
      CREATE_INSTANT_VOICE_CLONE = :create_instant_voice_clone
      CREATE_PROFESSIONAL_VOICE_CLONE = :create_professional_voice_clone
      PUBLISH_VOICE_TO_VOICE_LIBRARY = :publish_voice_to_voice_library
      SHARE_VOICE_EXTERNALLY = :share_voice_externally
      CREATE_USER_API_KEY = :create_user_api_key
      WORKSPACE_ANALYTICS_FULL_READ = :workspace_analytics_full_read
      WEBHOOKS_WRITE = :webhooks_write
      SERVICE_ACCOUNT_WRITE = :service_account_write
      GROUP_MEMBERS_MANAGE = :group_members_manage
      WORKSPACE_MEMBERS_READ = :workspace_members_read
      WORKSPACE_MEMBERS_INVITE = :workspace_members_invite
      WORKSPACE_MEMBERS_REMOVE = :workspace_members_remove
      TERMS_OF_SERVICE_ACCEPT = :terms_of_service_accept
      AUDIT_LOG_READ = :audit_log_read
      CONVERSATION_PRIVACY_MANAGE = :conversation_privacy_manage
      COPY_RESOURCES_CROSS_WORKSPACE = :copy_resources_cross_workspace
      SYNTHID_DETECTOR = :synthid_detector

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
