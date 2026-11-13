# frozen_string_literal: true

module Elevenlabs
  module Types
    class WidgetConfig < ::Elevenlabs::Internal::Types::Model
      field :variant, -> { ::Elevenlabs::Types::EmbedVariant }, optional: true, nullable: false
      field :placement, -> { ::Elevenlabs::Types::WidgetPlacement }, optional: true, nullable: false
      field :expandable, -> { ::Elevenlabs::Types::WidgetExpandable }, optional: true, nullable: false
      field :avatar, -> { ::Elevenlabs::Types::WidgetConfigAvatar }, optional: true, nullable: false
      field :feedback_mode, -> { ::Elevenlabs::Types::WidgetFeedbackMode }, optional: true, nullable: false
      field :end_feedback, -> { ::Elevenlabs::Types::WidgetEndFeedbackConfig }, optional: true, nullable: true
      field :bg_color, -> { String }, optional: true, nullable: false
      field :text_color, -> { String }, optional: true, nullable: false
      field :btn_color, -> { String }, optional: true, nullable: false
      field :btn_text_color, -> { String }, optional: true, nullable: false
      field :border_color, -> { String }, optional: true, nullable: false
      field :focus_color, -> { String }, optional: true, nullable: false
      field :border_radius, -> { Integer }, optional: true, nullable: true
      field :btn_radius, -> { Integer }, optional: true, nullable: true
      field :action_text, -> { String }, optional: true, nullable: true
      field :start_call_text, -> { String }, optional: true, nullable: true
      field :end_call_text, -> { String }, optional: true, nullable: true
      field :expand_text, -> { String }, optional: true, nullable: true
      field :listening_text, -> { String }, optional: true, nullable: true
      field :speaking_text, -> { String }, optional: true, nullable: true
      field :shareable_page_text, -> { String }, optional: true, nullable: true
      field :shareable_page_show_terms, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :terms_text, -> { String }, optional: true, nullable: true
      field :terms_html, -> { String }, optional: true, nullable: true
      field :terms_key, -> { String }, optional: true, nullable: true
      field :show_avatar_when_collapsed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :disable_banner, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :override_link, -> { String }, optional: true, nullable: true
      field :markdown_link_allowed_hosts, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AllowlistItem] }, optional: true, nullable: false
      field :markdown_link_include_www, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :markdown_link_allow_http, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :mic_muting_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :transcript_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :text_input_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :conversation_mode_toggle_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :default_expanded, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :always_expanded, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :dismissible, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :show_agent_status, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :show_conversation_id, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :strip_audio_tags, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :syntax_highlight_theme, -> { ::Elevenlabs::Types::WidgetConfigSyntaxHighlightTheme }, optional: true, nullable: true
      field :text_contents, -> { ::Elevenlabs::Types::WidgetTextContents }, optional: true, nullable: false
      field :styles, -> { ::Elevenlabs::Types::WidgetStyles }, optional: true, nullable: false
      field :show_resize_button, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :end_confirmation_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :mobile_fullscreen, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :transcript_speech_sync_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :language_selector, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :supports_text_only, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :custom_avatar_path, -> { String }, optional: true, nullable: true
      field :language_presets, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::WidgetLanguagePreset] }, optional: true, nullable: false

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
