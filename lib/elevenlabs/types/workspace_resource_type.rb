# frozen_string_literal: true

module Elevenlabs
  module Types
    module WorkspaceResourceType
      extend ::Elevenlabs::Internal::Types::Enum

      VOICE = :voice
      VOICE_COLLECTION = :voice_collection
      PRONUNCIATION_DICTIONARY = :pronunciation_dictionary
      DUBBING = :dubbing
      DUBBING_PROJECT = :dubbing_project
      PROJECT = :project
      CONVAI_AGENTS = :convai_agents
      CONVAI_KNOWLEDGE_BASE_DOCUMENTS = :convai_knowledge_base_documents
      CONVAI_TOOLS = :convai_tools
      CONVAI_SETTINGS = :convai_settings
      CONVAI_SECRETS = :convai_secrets
      WORKSPACE_AUTH_CONNECTIONS = :workspace_auth_connections
      CONVAI_PHONE_NUMBERS = :convai_phone_numbers
      CONVAI_MCP_SERVERS = :convai_mcp_servers
      CONVAI_API_INTEGRATION_CONNECTIONS = :convai_api_integration_connections
      CONVAI_API_INTEGRATION_TRIGGER_CONNECTIONS = :convai_api_integration_trigger_connections
      CONVAI_BATCH_CALLS = :convai_batch_calls
      CONVAI_AGENT_RESPONSE_TESTS = :convai_agent_response_tests
      CONVAI_TEST_SUITE_INVOCATIONS = :convai_test_suite_invocations
      CONVAI_CRAWL_JOBS = :convai_crawl_jobs
      CONVAI_CRAWL_TASKS = :convai_crawl_tasks
      CONVAI_KB_EXTERNAL_SYNC_JOBS = :convai_kb_external_sync_jobs
      CONVAI_WHATSAPP_ACCOUNTS = :convai_whatsapp_accounts
      CONVAI_AGENT_VERSIONS = :convai_agent_versions
      CONVAI_AGENT_BRANCHES = :convai_agent_branches
      CONVAI_AGENT_VERSIONS_DEPLOYMENTS = :convai_agent_versions_deployments
      CONVAI_AGENT_EXPERIMENTS = :convai_agent_experiments
      CONVAI_MEMORY_ENTRIES = :convai_memory_entries
      CONVAI_TEMPLATES = :convai_templates
      DASHBOARD = :dashboard
      DASHBOARD_CONFIGURATION = :dashboard_configuration
      CONVAI_AGENT_DRAFTS = :convai_agent_drafts
      RESOURCE_LOCATORS = :resource_locators
      ASSETS = :assets
      CONTENT_GENERATIONS = :content_generations
      CONTENT_TEMPLATES = :content_templates
      CONTENT_SKILLS = :content_skills
      SONGS = :songs
      TRANSCRIPTION_TASKS = :transcription_tasks
      AVATARS = :avatars
      AVATAR_VIDEO_GENERATIONS = :avatar_video_generations
      RESOURCE_COLLECTION = :resource_collection
      STUDIO_PROJECTS = :studio_projects
      CONVAI_ANALYSIS_ITEMS = :convai_analysis_items

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
