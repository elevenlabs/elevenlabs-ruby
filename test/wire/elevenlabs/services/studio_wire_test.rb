# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'
require 'webmock/minitest'
require 'uri'

class StudioWireTest < Minitest::Test
  # Class-scoped, not top-level: `rake test` loads every generated wire-test file into ONE Ruby
  # process, and a top-level `BASE_URL = ...` in each would redefine the same global constant
  # repeatedly (harmless here since the value never differs, but still a real
  # "already initialized constant" warning on every run after the first file).
  BASE_URL = 'https://wire-test.example.com'

  def setup
    WebMock.disable_net_connect!
  end

  def teardown
    WebMock.reset!
  end

  private

  # Preserve every value for repeated array query keys instead of collapsing to the last one.
  def wire_test_query(captured_uri)
    URI.decode_www_form(captured_uri.query.to_s).each_with_object({}) do |(key, value), query|
      (query[key] ||= []) << value
    end
  end

  # WebMock normalizes a captured request's header keys to Title-Case (`Api-Key`,
  # `Authorization`) regardless of the exact casing the SDK's own code used when it set the
  # header (e.g. `headers['api-key'] = ...`) -- confirmed against a real customer spec, where
  # every wire test asserting a non-canonically-cased header failed with `Actual: nil` despite
  # the SDK sending the header correctly. HTTP headers are case-insensitive by spec (RFC 7230
  # §3.2), so look them up that way rather than assuming any particular casing survives WebMock's
  # capture.
  def wire_test_header(headers, key)
    headers.find { |k, _| k.casecmp?(key) }&.last
  end

  public

  def test_create_podcast_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/studio/podcasts')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'project' => { 'project_id' => 'test-value', 'name' => 'test-value', 'create_date_unix' => 1, 'created_by_user_id' => 'test-value', 'default_title_voice_ref_id' => 'test-value', 'default_paragraph_voice_ref_id' => 'test-value', 'default_model_id' => 'test-value', 'last_conversion_date_unix' => 1, 'can_be_downloaded' => true, 'title' => 'test-value', 'author' => 'test-value', 'description' => 'test-value', 'genres' => ['test-value'], 'cover_image_url' => 'test-value', 'target_audience' => 'children', 'language' => 'test-value', 'content_type' => 'test-value', 'original_publication_date' => 'test-value', 'mature_content' => true, 'isbn_number' => 'test-value', 'volume_normalization' => true, 'state' => 'creating', 'access_level' => 'admin', 'fiction' => 'fiction', 'quality_check_on' => true, 'quality_check_on_when_bulk_convert' => true, 'creation_meta' => { 'creation_progress' => 1, 'status' => 'draft', 'type' => 'blank' }, 'source_type' => 'blank', 'chapters_enabled' => true, 'captions_enabled' => true, 'caption_style' => { 'template' => { 'key' => 'test-value', 'label' => 'test-value', 'requires_high_fps' => true }, 'text_font' => 'test-value', 'text_scale' => 1, 'text_color' => 'test-value', 'text_align' => 'start', 'text_style' => 'normal', 'text_weight' => 'normal', 'text_transform' => 'none', 'text_blend_mode' => 'normal', 'text_shadow' => { 'enabled' => true, 'color' => 'test-value', 'opacity' => 1, 'blur' => 1, 'offset_x' => 1, 'offset_y' => 1 }, 'text_outline' => { 'enabled' => true, 'color' => 'test-value', 'opacity' => 1, 'width' => 1 }, 'background_enabled' => true, 'background_color' => 'test-value', 'background_opacity' => 1, 'background_blur' => 1, 'background_border_radius' => 1, 'word_highlights_enabled' => true, 'word_highlights_color' => 'test-value', 'word_highlights_background_color' => 'test-value', 'word_highlights_opacity' => 1, 'word_highlights_border_radius' => 1, 'word_highlights_blur' => 1, 'section_animation' => { 'enter_type' => 'none', 'exit_type' => 'none' }, 'word_animation' => { 'enter_type' => 'none', 'exit_type' => 'none' }, 'character_animation' => { 'enter_type' => 'none', 'exit_type' => 'none' }, 'cursor_enabled' => true, 'width_pct' => 1, 'horizontal_placement' => { 'align' => 'left', 'translate_pct' => 1 }, 'vertical_placement' => { 'align' => 'top', 'translate_pct' => 1 }, 'auto_break_enabled' => true, 'max_lines_per_section' => 1, 'max_words_per_line' => 1 }, 'caption_style_template_overrides' => { 'key' => { 'template' => { 'key' => 'test-value', 'label' => 'test-value', 'requires_high_fps' => true }, 'text_font' => 'test-value', 'text_scale' => 1, 'text_color' => 'test-value', 'text_align' => 'start', 'text_style' => 'normal', 'text_weight' => 'normal', 'text_transform' => 'none', 'text_blend_mode' => 'normal', 'text_shadow' => { 'enabled' => true, 'color' => 'test-value', 'opacity' => 1, 'blur' => 1, 'offset_x' => 1, 'offset_y' => 1 }, 'text_outline' => { 'enabled' => true, 'color' => 'test-value', 'opacity' => 1, 'width' => 1 }, 'background_enabled' => true, 'background_color' => 'test-value', 'background_opacity' => 1, 'background_blur' => 1, 'background_border_radius' => 1, 'word_highlights_enabled' => true, 'word_highlights_color' => 'test-value', 'word_highlights_background_color' => 'test-value', 'word_highlights_opacity' => 1, 'word_highlights_border_radius' => 1, 'word_highlights_blur' => 1, 'section_animation' => { 'enter_type' => 'none', 'exit_type' => 'none' }, 'word_animation' => { 'enter_type' => 'none', 'exit_type' => 'none' }, 'character_animation' => { 'enter_type' => 'none', 'exit_type' => 'none' }, 'cursor_enabled' => true, 'width_pct' => 1, 'horizontal_placement' => { 'align' => 'left', 'translate_pct' => 1 }, 'vertical_placement' => { 'align' => 'top', 'translate_pct' => 1 }, 'auto_break_enabled' => true, 'max_lines_per_section' => 1, 'max_words_per_line' => 1 } }, 'public_share_id' => 'test-value', 'aspect_ratio' => '16:9', 'agent_settings' => { 'tool_settings' => { 'key' => { 'skip_confirmation' => true } } }, 'default_title_voice_id' => 'test-value', 'default_paragraph_voice_id' => 'test-value' } }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.studio.create_podcast(safety_identifier: 'test-value', model_id: 'test-value', mode: { 'type' => 'conversation', 'conversation' => { 'host_voice_id' => 'test-value', 'guest_voice_id' => 'test-value' } }, source: { 'type' => 'text', 'text' => 'test-value' }, quality_preset: 'standard', duration_scale: 'short', language: 'te', intro: 'test-value', outro: 'test-value', instructions_prompt: 'test-value', highlights: ['test-value'], callback_url: 'test-value', apply_text_normalization: 'auto')

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/studio/podcasts', captured.uri.path)
    assert_equal('test-value', wire_test_header(captured.headers, 'safety-identifier'))
    assert_equal({ 'model_id' => 'test-value', 'mode' => { 'type' => 'conversation', 'conversation' => { 'host_voice_id' => 'test-value', 'guest_voice_id' => 'test-value' } }, 'source' => { 'type' => 'text', 'text' => 'test-value' }, 'quality_preset' => 'standard', 'duration_scale' => 'short', 'language' => 'te', 'intro' => 'test-value', 'outro' => 'test-value', 'instructions_prompt' => 'test-value', 'highlights' => ['test-value'], 'callback_url' => 'test-value', 'apply_text_normalization' => 'auto' }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_create_podcast_raises_on_422
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/studio/podcasts')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.studio.create_podcast(safety_identifier: 'test-value', model_id: 'test-value', mode: { 'type' => 'conversation', 'conversation' => { 'host_voice_id' => 'test-value', 'guest_voice_id' => 'test-value' } }, source: { 'type' => 'text', 'text' => 'test-value' }, quality_preset: 'standard', duration_scale: 'short', language: 'te', intro: 'test-value', outro: 'test-value', instructions_prompt: 'test-value', highlights: ['test-value'], callback_url: 'test-value', apply_text_normalization: 'auto') }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end
end
