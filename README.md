# ElevenLabs Ruby Library

![LOGO](https://github.com/elevenlabs/elevenlabs-python/assets/12028621/21267d89-5e82-4e7e-9c81-caf30b237683)

[![fern shield](https://img.shields.io/badge/%F0%9F%8C%BF-SDK%20generated%20by%20Fern-brightgreen)](https://buildwithfern.com/?utm_source=fern-elevenlabs/elevenlabs-ruby/readme)
[![Discord](https://badgen.net/badge/black/ElevenLabs/icon?icon=discord&label)](https://discord.gg/elevenlabs)
[![Twitter](https://badgen.net/badge/black/elevenlabsio/icon?icon=twitter&label)](https://twitter.com/elevenlabsio)
[![gem version](https://img.shields.io/gem/v/elevenlabs-ruby-sdk)](https://rubygems.org/gems/elevenlabs-ruby-sdk)

The official Ruby SDK for [ElevenLabs](https://elevenlabs.io/). ElevenLabs brings the most compelling, rich and lifelike voices to creators and developers in just a few lines of code.

## 📖 API & Docs

Check out the [HTTP API documentation](https://elevenlabs.io/docs/api-reference). A full reference for this library is available [here](./reference.md).

## Requirements

This SDK requires Ruby `>= 3.3`.

## Install

```sh
gem install elevenlabs-ruby-sdk
```

Or add it to your `Gemfile`:

```ruby
gem "elevenlabs-ruby-sdk"
```

## Usage

### Main Models

1. **Eleven v4** (`eleven_v4`)
    - Highest quality and most expressive speech, with reliable voice cloning across long generations
    - 90+ languages with consistent voice quality across language switches
    - Up to 10,000 characters (~10 minutes of audio) per request
    - Used via the [Text to Dialogue API](https://elevenlabs.io/docs/api-reference/text-to-dialogue/convert)

2. **Eleven v4 Turbo** (`eleven_v4_turbo`)
    - State-of-the-art real-time speech, with a median latency of ~100ms
    - 90+ languages
    - Ideal for voice agents and other latency-sensitive use cases

3. **Eleven Multilingual v2** (`eleven_multilingual_v2`)
    - Excels in stability, language diversity, and accent accuracy
    - The most stable choice for long-form Text to Speech
    - Supports 29 languages

4. **Eleven Flash v2.5** (`eleven_flash_v2_5`)
    - Ultra-low latency and lowest cost
    - Supports 32 languages

For more detailed information about these models and others, visit the [ElevenLabs Models documentation](https://elevenlabs.io/docs/models).

Instantiate and use the client with the following:

```ruby
require "elevenlabs"

# Reads the API key from the ELEVENLABS_API_KEY environment variable.
# Pass it explicitly with Elevenlabs::Client.new(api_key: "YOUR_API_KEY") if you prefer.
client = Elevenlabs::Client.new

audio = client.text_to_speech.convert(
  voice_id: "JBFqnCBsd6RMkjVDRZzb",
  text: "The first move is what sets everything in motion.",
  model_id: "eleven_multilingual_v2",
  output_format: "mp3_44100_128"
)

# The response is a lazy stream. `read` returns the whole body in one call.
File.binwrite("output.mp3", audio.read)
```

### Text to Dialogue (Eleven v4)

Eleven v4 and Eleven v4 Turbo are served through the Text to Dialogue API, which turns a list of speaker turns into a single expressive audio stream.

```ruby
audio = client.text_to_dialogue.convert(
  model_id: "eleven_v4",
  output_format: "mp3_44100_128",
  inputs: [
    Elevenlabs::Types::DialogueInput.new(text: "[giggling] Knock knock", voice_id: "JBFqnCBsd6RMkjVDRZzb"),
    Elevenlabs::Types::DialogueInput.new(text: "[curious] Who is there?", voice_id: "Aw4FAjKCGjjNkVhN1Xmq")
  ]
)

# Write each chunk as it arrives.
File.open("dialogue.mp3", "wb") do |file|
  audio.each { |chunk| file.write(chunk) }
end
```

## Voices

List all your available voices with `search`.

```ruby
response = client.voices.search
response.voices.each do |voice|
  puts voice.name
end
```

For information about the structure of the voices output, please refer to the [official ElevenLabs API documentation for Get Voices](https://elevenlabs.io/docs/api-reference/get-voices).

## Streaming

Stream audio in real-time, as it's being generated. `convert` and `stream` both return a lazy,
single-use `Enumerator` of binary chunks: the request is sent on the first iteration and each chunk
is yielded as it arrives, so playback or a file write can start before the server has finished.

```ruby
audio = client.text_to_speech.stream(
  voice_id: "JBFqnCBsd6RMkjVDRZzb",
  text: "This is a... streaming voice.",
  model_id: "eleven_multilingual_v2",
  output_format: "mp3_44100_128"
)

audio.each do |chunk|
  # Process each chunk as it arrives.
  $stdout.write(chunk)
end
```

Iterating the stream a second time raises rather than re-sending the request. Call `read` to get the
whole body as one binary `String` instead, or `to_a` on the first pass to keep the chunks.

## Environments

This SDK allows you to configure different environments for API requests. It defaults to the production environment.

```ruby
client = Elevenlabs::Client.new(
  base_url: Elevenlabs::Environment::PRODUCTION_US
)
```

Available environments:
- `Elevenlabs::Environment::PRODUCTION`
- `Elevenlabs::Environment::PRODUCTION_US`
- `Elevenlabs::Environment::PRODUCTION_EU`
- `Elevenlabs::Environment::PRODUCTION_INDIA`
- `Elevenlabs::Environment::PRODUCTION_SINGAPORE`

## Exception Handling

When the API returns a non-success status code (4xx or 5xx), the SDK raises a subclass of
`Elevenlabs::Errors::ResponseError`. The HTTP status code is available via `#code` and the raw
response body via `#body`. Specific status codes raise named subclasses (for example
`Elevenlabs::Errors::NotFoundError` for a 404), so you can rescue the one you care about.

```ruby
begin
  client.text_to_speech.convert(...)
rescue Elevenlabs::Errors::NotFoundError => e
  # Handle a 404 specifically.
rescue Elevenlabs::Errors::ResponseError => e
  puts "API error occurred: #{e.message}"
  puts "Status code: #{e.code}"
  puts "Response body: #{e.body}"
  # Optionally, re-raise the exception or handle accordingly.
end
```

## Advanced

### Retries

The SDK is instrumented with automatic retries with exponential backoff. A request will be retried as
long as the request is deemed retryable and the number of retry attempts has not grown larger than the
configured retry limit (default: 2).

A request is deemed retryable when any of the following HTTP status codes is returned:

- [408](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/408) (Timeout)
- [429](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429) (Too Many Requests)
- [5XX](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#server_error_responses) (Internal Server Error)

Configure the limit on the client:

```ruby
client = Elevenlabs::Client.new(max_retries: 3)
```

### Timeouts

The open, read and write timeout defaults to 60 seconds. Set it on the client, or per call:

```ruby
client = Elevenlabs::Client.new(timeout: 10)
client.text_to_speech.convert(..., request_options: { timeout: 2.5 })
```

A request that exhausts its retries after timing out raises `Elevenlabs::Errors::TimeoutError`, and
one that never reached the server at all — refused connection, unresolvable host, failed TLS
handshake — raises `Elevenlabs::Errors::ConnectionError`. Both are subclasses of
`Elevenlabs::Errors::ApiError`, carry no status code (there was no response), and keep the underlying
transport exception on `#cause`.

### Plain HTTP

Requests to a plain `http://` URL are refused unless the host is `localhost`, so credentials are
never sent unencrypted by mistake. To reach a trusted http-only host, such as an internal proxy, opt
in on the client:

```ruby
client = Elevenlabs::Client.new(
  base_url: "http://proxy.internal:8080",
  allow_insecure_http: true
)
```

### Per-request Options

Every method accepts a `request_options:` hash to override behavior for a single call — a different
base URL, additional headers, or additional query parameters:

```ruby
client.text_to_speech.convert(
  ...,
  request_options: {
    base_url: "https://staging.example.com",
    timeout: 5,
    additional_headers: { "X-Custom-Header" => "value" },
    additional_query_parameters: { "trace" => "true" }
  }
)
```

### WebSockets

`client.dubbing.live(...)` opens a connection and returns a `DubbingSocket`. Send with its typed
methods (or `send`), iterate the socket to read messages until the server closes it, and call `close`
when done. Passing a block connects the socket, yields it, and closes it automatically when the block
returns:

```ruby
client.dubbing.live(target_language: "es", source_language: "en") do |socket|
  socket.send_publish(...)
  socket.each do |message|
    # Handle each message.
  end
end
```

The SDK has one socket per channel:

- `client.dubbing.live` returns a `DubbingSocket`
- `client.text_to_speech.realtime` returns a `TextToSpeechSocket`
- `client.text_to_dialogue.realtime` returns a `TextToDialogueSocket`
- `client.speech_to_text.realtime` returns a `SpeechToTextSocket`
- `client.speech_engine.upstream` returns a `SpeechEngineSocket`
- `client.text_to_dialogue_multi_context.realtime` returns a `TextToDialogueMultiContextSocket`
- `client.text_to_speech_multi_context.realtime` returns a `TextToSpeechMultiContextSocket`
- `client.translation.realtime` returns a `TranslationSocket`

Reading blocks the thread, so run sockets in a CLI worker or a background thread, not inside a web
request.

#### Bounding a blocking read

With no `timeout`, `each` and `recv` wait for the next message until the connection closes, so they
can hang on a server that goes quiet. Pass `timeout:` (seconds) to `recv` to give a read a deadline;
it returns `nil` when the timeout passes or the connection closes, and the connection stays usable:

```ruby
socket = client.dubbing.live(target_language: "es", source_language: "en")
begin
  while (message = socket.recv(timeout: 5))
    # Handle each message.
  end
ensure
  socket.close
end
```

## Languages Supported

Explore [all models & languages](https://elevenlabs.io/docs/models).

## Contributing

While we value open-source contributions to this SDK, this library is generated programmatically.
Additions made directly to this library would have to be moved over to our generation code,
otherwise they would be overwritten upon the next generated release. Feel free to open a PR as
a proof of concept, but know that we will not be able to merge it as-is. We suggest opening
an issue first to discuss with us!

On the other hand, contributions to the README are always very welcome!
