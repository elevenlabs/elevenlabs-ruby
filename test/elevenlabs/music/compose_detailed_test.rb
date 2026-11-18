# frozen_string_literal: true

require 'minitest/autorun'
require 'webmock/minitest'
require 'elevenlabs'
require 'elevenlabs/music/compose_detailed'

module Elevenlabs
  module Music
    class ComposeDetailedTest < Minitest::Test
      BASE = 'https://api.example.test'
      URL = "#{BASE}/v1/music/detailed".freeze
      BOUNDARY = '--boundary123'
      METADATA = {
        'composition_plan' => { 'positive_global_styles' => ['pop'], 'negative_global_styles' => [], 'sections' => [] },
        'song_metadata' => {
          'title' => 'Test', 'description' => 'A test song', 'genres' => ['pop'], 'languages' => ['en'], 'is_explicit' => false
        },
        'words_timestamps' => nil,
      }.freeze
      # Every byte value, so an off-by-one at either end of the audio part shows up.
      AUDIO = ((0..255).map(&:chr).join * 4).b.freeze

      def setup
        @client = Elevenlabs::Client.new(api_key: 'test-key', base_url: BASE, max_retries: 0)
      end

      def teardown
        WebMock.reset!
      end

      def multipart(line_break, json: JSON.generate(METADATA), disposition: true)
        body = +''.b
        body << BOUNDARY << line_break
        body << 'Content-Type: application/json' << line_break << line_break
        body << json << line_break
        body << BOUNDARY << line_break
        body << 'Content-Type: audio/mpeg' << line_break
        body << 'Content-Disposition: attachment; filename="test_song.mp3"' << line_break if disposition
        body << line_break << AUDIO
        body << line_break << BOUNDARY << '--' << line_break
      end

      def reply(body, headers = {})
        { status: 200, body: body, headers: { 'Content-Type' => 'multipart/mixed; boundary=boundary123' }.merge(headers) }
      end

      def test_parses_metadata_and_exact_audio_with_crlf_line_endings
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(multipart("\r\n")))

        song = @client.music.compose_detailed(prompt: 'Epic orchestral music', music_length_ms: 10_000)

        assert_kind_of ComposeDetailedResponse, song
        assert_equal METADATA, song.json
        assert_equal AUDIO, song.audio, 'audio must be byte-for-byte, with the closing delimiter stripped'
      end

      def test_returns_the_filename_and_song_id_header
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(multipart("\r\n"), 'song-id' => 'song_abc'))

        song = @client.music.compose_detailed(prompt: 'x', store_for_inpainting: true)

        assert_equal 'test_song.mp3', song.filename
        assert_equal 'song_abc', song.song_id
      end

      def test_parses_lf_line_endings
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(multipart("\n")))

        song = @client.music.compose_detailed(prompt: 'x')

        assert_equal METADATA, song.json
        assert_equal AUDIO, song.audio
        assert_equal 'test_song.mp3', song.filename
      end

      def test_sends_the_generated_request
        stub = stub_request(:post, URL)
               .with(query: { 'output_format' => 'mp3_44100_128' }) do |request|
          body = JSON.parse(request.body)
          body['prompt'] == 'Epic orchestral music' && body['music_length_ms'] == 10_000 && !body.key?('output_format')
        end
               .to_return(reply(multipart("\r\n")))

        @client.music.compose_detailed(prompt: 'Epic orchestral music', music_length_ms: 10_000, output_format: 'mp3_44100_128')

        assert_requested stub
      end

      def test_song_id_is_nil_without_the_header
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(multipart("\r\n")))

        assert_nil @client.music.compose_detailed(prompt: 'x').song_id
      end

      def test_defaults_the_filename_without_content_disposition
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(multipart("\r\n", disposition: false)))

        song = @client.music.compose_detailed(prompt: 'x')

        assert_equal ComposeDetailed::DEFAULT_FILENAME, song.filename
        assert_equal AUDIO, song.audio
      end

      def test_parses_pretty_printed_json
        pretty = JSON.pretty_generate(METADATA).gsub("\n", "\r\n")
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(multipart("\r\n", json: pretty)))

        assert_equal METADATA, @client.music.compose_detailed(prompt: 'x').json
      end

      def test_raises_without_a_json_part
        body = "#{BOUNDARY}\r\nContent-Type: audio/mpeg\r\n\r\n".b + AUDIO + "\r\n#{BOUNDARY}--\r\n".b
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(body))

        error = assert_raises(Elevenlabs::Errors::ApiError) { @client.music.compose_detailed(prompt: 'x') }
        assert_match(/JSON part/, error.message)
      end

      def test_raises_without_an_audio_part
        body = "#{BOUNDARY}\r\nContent-Type: application/json\r\n\r\n{}\r\n#{BOUNDARY}--\r\n"
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(body))

        error = assert_raises(Elevenlabs::Errors::ApiError) { @client.music.compose_detailed(prompt: 'x') }
        assert_match(/audio part/, error.message)
      end

      def test_api_errors_keep_the_generated_error_handling
        stub_request(:post, URL).with(query: hash_including({}))
                                .to_return(status: 422, body: '{"detail":"bad"}', headers: { 'Content-Type' => 'application/json' })

        assert_raises(Elevenlabs::Errors::ResponseError) { @client.music.compose_detailed(prompt: 'x') }
      end

      def test_raises_when_the_body_ends_mid_audio
        full = multipart("\r\n")
        # Cut inside the audio, so the closing delimiter never arrives.
        cut = full.byteslice(0, full.bytesize - "\r\n#{BOUNDARY}--\r\n".bytesize - 100)
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(cut))

        error = assert_raises(Elevenlabs::Errors::ApiError) { @client.music.compose_detailed(prompt: 'x') }
        assert_match(/incomplete/, error.message)
      end

      def test_raises_on_a_partial_closing_boundary
        full = multipart("\r\n")
        cut = full.byteslice(0, full.bytesize - "3--\r\n".bytesize) # ends in "...\r\n--boundary12"
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(cut))

        error = assert_raises(Elevenlabs::Errors::ApiError) { @client.music.compose_detailed(prompt: 'x') }
        assert_match(/incomplete/, error.message)
      end

      def test_skips_a_preamble_using_the_content_type_boundary
        body = "This is a multipart message.\r\n".b + multipart("\r\n")
        stub_request(:post, URL).with(query: hash_including({})).to_return(reply(body))

        song = @client.music.compose_detailed(prompt: 'x')

        assert_equal METADATA, song.json
        assert_equal AUDIO, song.audio
      end

      def test_reads_the_boundary_parameter
        assert_equal 'abc', ComposeDetailed::MultipartParser.boundary_from('multipart/mixed; boundary="abc"')
        assert_equal '----boundaryf00', ComposeDetailed::MultipartParser.boundary_from('multipart/mixed; boundary=----boundaryf00')
        assert_nil ComposeDetailed::MultipartParser.boundary_from('application/json')
      end

      def test_parser_finds_the_audio_part_before_the_json_part
        body = "#{BOUNDARY}\r\nContent-Type: audio/mpeg\r\n\r\n".b + AUDIO +
               "\r\n#{BOUNDARY}\r\nContent-Type: application/json\r\n\r\n{\"a\":1}\r\n#{BOUNDARY}--\r\n".b

        parsed = ComposeDetailed::MultipartParser.parse(body)

        assert_equal({ 'a' => 1 }, parsed[:json])
        assert_equal AUDIO, parsed[:audio]
      end
    end
  end
end
