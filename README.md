# Elevenlabs Ruby Library

The Elevenlabs Ruby library provides convenient access to the API from Ruby.

## Table of Contents

- [Reference](#reference)
- [Installation](#installation)
- [Usage](#usage)
- [Errors](#errors)
- [Advanced](#advanced)
  - [Retries](#retries)
  - [Per-request Options](#per-request-options)
- [Contributing](#contributing)

## Reference

A full reference for this library is available [here](./reference.md).

## Installation

```sh
gem install elevenlabs-ruby-sdk
```

## Usage

```ruby
require "elevenlabs"

client = Elevenlabs::Client.new
# See reference.md for the available resources and methods, e.g.:
# client.some_resource.some_method(...)
```

## Errors

When the API returns a non-success status code (4xx or 5xx), the SDK raises a subclass of
`Elevenlabs::Errors::ResponseError`. The HTTP status code is
available via `#code` and the raw response body via `#message`.

```ruby
begin
  client.some_resource.some_method(...)
rescue Elevenlabs::Errors::NotFoundError => e
  # handle a 404 specifically
rescue Elevenlabs::Errors::ResponseError => e
  puts e.code
  puts e.message
end
```

## Advanced

### Retries

Requests that fail with a retryable status code (408, 429, and 5xx) are automatically retried with
exponential backoff, up to `max_retries` times. A request that times out is retried on the same
terms. Configure the limit on the client:

```ruby
client = Elevenlabs::Client.new(max_retries: 3)
```

### Timeouts

The open, read and write timeout defaults to 240 seconds. Set it on the client, or per call:

```ruby
client = Elevenlabs::Client.new(timeout: 10)
client.some_resource.some_method(request_options: { timeout: 2.5 })
```

A request that exhausts its retries after timing out raises
`Elevenlabs::Errors::TimeoutError`, and one that never reached the
server at all — refused connection, unresolvable host, failed TLS handshake — raises
`Elevenlabs::Errors::ConnectionError`. Both are subclasses of
`Elevenlabs::Errors::ApiError`, carry no status code (there was no
response), and keep the underlying transport exception on `#cause`.

### Plain HTTP

Requests to a plain `http://` URL are refused unless the host is `localhost`, so credentials are
never sent unencrypted by mistake. To reach a trusted http-only host, such as an internal proxy,
opt in on the client:

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
client.some_resource.some_method(
  request_options: {
    base_url: "https://staging.example.com",
    timeout: 5,
    additional_headers: { "X-Custom-Header" => "value" },
    additional_query_parameters: { "trace" => "true" }
  }
)
```

## Contributing

While we value open-source contributions to this SDK, this library is generated programmatically.
Additions made directly to this library would have to be moved over to our generation code,
otherwise they would be overwritten upon the next generated release. Feel free to open a PR as
a proof of concept, but know that we will not be able to merge it as-is. We suggest opening
an issue first to discuss with us!

On the other hand, contributions to the README are always very welcome!
