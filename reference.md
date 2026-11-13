# Reference

## History

### `elevenlabs.history.list`

`GET /v1/history`

Get generated items

**Parameters:**

- `page_size`
- `start_after_history_item_id`
- `voice_id`
- `model_id`
- `date_before_unix`
- `date_after_unix`
- `sort_direction`
- `search`
- `source`

### `elevenlabs.history.get`

`GET /v1/history/{history_item_id}`

Get history item

**Parameters:**

- `history_item_id` (required)

### `elevenlabs.history.delete`

`DELETE /v1/history/{history_item_id}`

Delete history item

**Parameters:**

- `history_item_id` (required)

### `elevenlabs.history.get_audio`

`GET /v1/history/{history_item_id}/audio`

Get audio from history item

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `history_item_id` (required)

### `elevenlabs.history.download`

`POST /v1/history/download`

Download history items

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `history_item_ids` (required)
- `output_format`

## TextToSoundEffects

### `elevenlabs.text_to_sound_effects.convert`

`POST /v1/sound-generation`

Create sound effect

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `output_format`
- `enable_logging`
- `text` (required)
- `loop`
- `duration_seconds`
- `prompt_influence`
- `model_id`

## AudioIsolation

### `elevenlabs.audio_isolation.convert`

`POST /v1/audio-isolation`

Audio isolation

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `audio` (required)
- `file_format`
- `preview_b64`

### `elevenlabs.audio_isolation.list`

`GET /v1/audio-isolation/history`

Get Audio Isolation History

**Parameters:**

- `page_size`
- `page`
- `search`

### `elevenlabs.audio_isolation.delete`

`DELETE /v1/audio-isolation/history/{history_item_id}`

Delete Audio Isolation History Item

**Parameters:**

- `history_item_id` (required)

### `elevenlabs.audio_isolation.stream`

`POST /v1/audio-isolation/stream`

Audio isolation stream

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `audio` (required)
- `file_format`

## AudioEffects

### `elevenlabs.audio_effects.get_catalog`

`GET /v1/audio-effects/catalog`

Get Audio Effects Catalog

## Samples

### `elevenlabs.samples.delete`

`DELETE /v1/voices/{voice_id}/samples/{sample_id}`

Delete voice sample

**Parameters:**

- `voice_id` (required)
- `sample_id` (required)

### `elevenlabs.samples.create`

`POST /v1/voices/pvc/{voice_id}/samples`

Add Samples To Pvc Voice

**Parameters:**

- `voice_id` (required)
- `files` (required)
- `remove_background_noise`

### `elevenlabs.samples.update`

`POST /v1/voices/pvc/{voice_id}/samples/{sample_id}`

Update Pvc Voice Sample

**Parameters:**

- `voice_id` (required)
- `sample_id` (required)
- `remove_background_noise`
- `selected_speaker_ids`
- `trim_start_time`
- `trim_end_time`
- `file_name`

### `elevenlabs.samples.delete`

`DELETE /v1/voices/pvc/{voice_id}/samples/{sample_id}`

Delete Pvc Voice Sample

**Parameters:**

- `voice_id` (required)
- `sample_id` (required)

## Voices Samples Audio

### `elevenlabs.voices.samples.audio.get`

`GET /v1/voices/{voice_id}/samples/{sample_id}/audio`

Get audio from sample

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `voice_id` (required)
- `sample_id` (required)

### `elevenlabs.voices.samples.audio.get`

`GET /v1/dubbing/{dubbing_id}/audio/{language_code}`

Get dubbed audio

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `dubbing_id` (required)
- `language_code` (required)

### `elevenlabs.voices.samples.audio.get`

`GET /v1/convai/conversations/{conversation_id}/audio`

Get Conversation Audio

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `conversation_id` (required)

### `elevenlabs.voices.samples.audio.get`

`GET /v1/voices/pvc/{voice_id}/samples/{sample_id}/audio`

Retrieve Voice Sample Audio

**Parameters:**

- `voice_id` (required)
- `sample_id` (required)
- `remove_background_noise`

### `elevenlabs.voices.samples.audio.get`

`GET /v1/voices/pvc/{voice_id}/samples/{sample_id}/speakers/{speaker_id}/audio`

Retrieve Separated Speaker Audio

**Parameters:**

- `voice_id` (required)
- `sample_id` (required)
- `speaker_id` (required)

## TextToSpeech

### `elevenlabs.text_to_speech.convert`

`POST /v1/text-to-speech/{voice_id}`

Create speech

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `voice_id` (required)
- `enable_logging`
- `optimize_streaming_latency`
- `output_format`
- `text` (required)
- `model_id`
- `language_code`
- `voice_settings`
- `pronunciation_dictionary_locators`
- `seed`
- `previous_text`
- `next_text`
- `previous_request_ids`
- `next_request_ids`
- `use_pvc_as_ivc`
- `apply_text_normalization`
- `apply_language_text_normalization`
- `audio_effects`

### `elevenlabs.text_to_speech.convert_with_timestamps`

`POST /v1/text-to-speech/{voice_id}/with-timestamps`

Create speech with timing

**Parameters:**

- `voice_id` (required)
- `enable_logging`
- `optimize_streaming_latency`
- `output_format`
- `text` (required)
- `model_id`
- `language_code`
- `voice_settings`
- `pronunciation_dictionary_locators`
- `seed`
- `previous_text`
- `next_text`
- `previous_request_ids`
- `next_request_ids`
- `use_pvc_as_ivc`
- `apply_text_normalization`
- `apply_language_text_normalization`
- `audio_effects`

### `elevenlabs.text_to_speech.stream`

`POST /v1/text-to-speech/{voice_id}/stream`

Stream speech

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `voice_id` (required)
- `enable_logging`
- `optimize_streaming_latency`
- `output_format`
- `text` (required)
- `model_id`
- `language_code`
- `voice_settings`
- `pronunciation_dictionary_locators`
- `seed`
- `previous_text`
- `next_text`
- `previous_request_ids`
- `next_request_ids`
- `use_pvc_as_ivc`
- `apply_text_normalization`
- `apply_language_text_normalization`
- `audio_effects`

### `elevenlabs.text_to_speech.stream_with_timestamps`

`POST /v1/text-to-speech/{voice_id}/stream/with-timestamps`

Stream speech with timing

**Parameters:**

- `voice_id` (required)
- `enable_logging`
- `optimize_streaming_latency`
- `output_format`
- `text` (required)
- `model_id`
- `language_code`
- `voice_settings`
- `pronunciation_dictionary_locators`
- `seed`
- `previous_text`
- `next_text`
- `previous_request_ids`
- `next_request_ids`
- `use_pvc_as_ivc`
- `apply_text_normalization`
- `apply_language_text_normalization`
- `audio_effects`

### `elevenlabs.text_to_speech.list`

`GET /v1/flows/text-to-speech`

List Speech Generations

**Parameters:**

- `cursor`
- `page_size`
- `status`
- `model_id`

### `elevenlabs.text_to_speech.create`

`POST /v1/flows/text-to-speech`

Create Speech Generation

### `elevenlabs.text_to_speech.get`

`GET /v1/flows/text-to-speech/{generation_id}`

Get Speech Generation

**Parameters:**

- `generation_id` (required)

## TextToDialogue

### `elevenlabs.text_to_dialogue.convert`

`POST /v1/text-to-dialogue`

Create dialogue

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `output_format`
- `enable_logging`
- `inputs` (required)
- `model_id`
- `language_code`
- `settings`
- `previous_text`
- `future_text`
- `pronunciation_dictionary_locators`
- `seed`
- `apply_text_normalization`
- `use_pvc_as_ivc`
- `previous_request_ids`
- `next_request_ids`
- `audio_effects`

### `elevenlabs.text_to_dialogue.stream`

`POST /v1/text-to-dialogue/stream`

Stream dialogue

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `output_format`
- `enable_logging`
- `inputs` (required)
- `model_id`
- `language_code`
- `settings`
- `previous_text`
- `future_text`
- `pronunciation_dictionary_locators`
- `seed`
- `apply_text_normalization`
- `use_pvc_as_ivc`
- `previous_request_ids`
- `next_request_ids`
- `audio_effects`

### `elevenlabs.text_to_dialogue.stream_with_timestamps`

`POST /v1/text-to-dialogue/stream/with-timestamps`

Text To Dialogue Streaming With Timestamps

**Parameters:**

- `output_format`
- `enable_logging`
- `inputs` (required)
- `model_id`
- `language_code`
- `settings`
- `pronunciation_dictionary_locators`
- `seed`
- `apply_text_normalization`
- `use_pvc_as_ivc`
- `previous_request_ids`
- `next_request_ids`
- `previous_text`
- `future_text`
- `audio_effects`

### `elevenlabs.text_to_dialogue.convert_with_timestamps`

`POST /v1/text-to-dialogue/with-timestamps`

Text To Dialogue With Timestamps

**Parameters:**

- `output_format`
- `enable_logging`
- `inputs` (required)
- `model_id`
- `language_code`
- `settings`
- `pronunciation_dictionary_locators`
- `seed`
- `apply_text_normalization`
- `use_pvc_as_ivc`
- `previous_request_ids`
- `next_request_ids`
- `previous_text`
- `future_text`
- `audio_effects`

## SpeechToSpeech

### `elevenlabs.speech_to_speech.convert`

`POST /v1/voice-changer/{voice_id}`

Voice changer

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `voice_id` (required)
- `enable_logging`
- `optimize_streaming_latency`
- `output_format`
- `audio`
- `model_id`
- `voice_settings`
- `seed`
- `remove_background_noise`
- `file_format`

### `elevenlabs.speech_to_speech.stream`

`POST /v1/voice-changer/{voice_id}/stream`

Voice changer stream

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `voice_id` (required)
- `enable_logging`
- `optimize_streaming_latency`
- `output_format`
- `audio`
- `model_id`
- `voice_settings`
- `seed`
- `remove_background_noise`
- `file_format`

## TextToVoice

### `elevenlabs.text_to_voice.create`

`POST /v1/text-to-voice`

Create A New Voice From Voice Preview

**Parameters:**

- `voice_name` (required)
- `voice_description` (required)
- `generated_voice_id` (required)
- `labels`
- `played_not_selected_voice_ids`

### `elevenlabs.text_to_voice.design`

`POST /v1/text-to-voice/design`

Design A Voice.

**Parameters:**

- `output_format`
- `voice_description` (required)
- `model_id`
- `text`
- `auto_generate_text`
- `loudness`
- `seed`
- `guidance_scale`
- `stream_previews`
- `should_enhance`
- `remixing_session_id`
- `remixing_session_iteration_id`
- `quality`
- `reference_audio_base64`
- `prompt_strength`

### `elevenlabs.text_to_voice.remix`

`POST /v1/text-to-voice/{voice_id}/remix`

Remix A Voice.

**Parameters:**

- `voice_id` (required)
- `output_format`
- `voice_description` (required)
- `text`
- `auto_generate_text`
- `loudness`
- `seed`
- `guidance_scale`
- `stream_previews`
- `remixing_session_id`
- `remixing_session_iteration_id`
- `prompt_strength`

## TextToVoice Preview

### `elevenlabs.text_to_voice.preview.stream`

`GET /v1/text-to-voice/{generated_voice_id}/stream`

Text To Voice Preview Streaming

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `generated_voice_id` (required)

## User

### `elevenlabs.user.get`

`GET /v1/user`

Get user

## User Subscription

### `elevenlabs.user.subscription.get`

`GET /v1/user/subscription`

Get user subscription

## Voices Collections

### `elevenlabs.voices.collections.list`

`GET /v1/voices/collections`

List Voice Collections

### `elevenlabs.voices.collections.create`

`POST /v1/voices/collections`

Create Voice Collection

**Parameters:**

- `title` (required)
- `icon` (required)

### `elevenlabs.voices.collections.get`

`GET /v1/voices/collections/{collection_id}`

Get Voice Collection

**Parameters:**

- `collection_id` (required)

### `elevenlabs.voices.collections.update`

`PATCH /v1/voices/collections/{collection_id}`

Update Voice Collection

**Parameters:**

- `collection_id` (required)
- `title`
- `icon`

### `elevenlabs.voices.collections.delete`

`DELETE /v1/voices/collections/{collection_id}`

Delete Voice Collection

**Parameters:**

- `collection_id` (required)

### `elevenlabs.voices.collections.add_voice`

`POST /v1/voices/collections/{collection_id}/voice/{voice_id}`

Add Voice To Collection

**Parameters:**

- `collection_id` (required)
- `voice_id` (required)

### `elevenlabs.voices.collections.remove_voice`

`DELETE /v1/voices/collections/{collection_id}/voice/{voice_id}`

Remove Voice From Collection

**Parameters:**

- `collection_id` (required)
- `voice_id` (required)

## Voices Settings

### `elevenlabs.voices.settings.get_default`

`GET /v1/voices/settings/default`

Get default voice settings

### `elevenlabs.voices.settings.get`

`GET /v1/voices/{voice_id}/settings`

Get voice settings

**Parameters:**

- `voice_id` (required)

### `elevenlabs.voices.settings.update`

`POST /v1/voices/{voice_id}/settings/edit`

Edit voice settings

**Parameters:**

- `voice_id` (required)
- `stability`
- `use_speaker_boost`
- `similarity_boost`
- `style`
- `speed`
- `clone_strength`

### `elevenlabs.voices.settings.get`

`GET /v1/convai/settings`

Get Convai Settings

### `elevenlabs.voices.settings.update`

`PATCH /v1/convai/settings`

Update Convai Settings

**Parameters:**

- `conversation_initiation_client_data_webhook`
- `webhooks`
- `can_use_mcp_servers`
- `rag_retention_period_days`
- `conversation_embedding_retention_days`
- `default_livekit_stack`

### `elevenlabs.voices.settings.get`

`GET /v1/convai/settings/dashboard`

Get Convai Dashboard Settings

### `elevenlabs.voices.settings.update`

`PATCH /v1/convai/settings/dashboard`

Update Convai Dashboard Settings

**Parameters:**

- `charts`

## Voices Accents

### `elevenlabs.voices.accents.get`

`GET /v1/voices/accents`

Get Voice Accents

**Parameters:**

- `language`
- `model_id`

## Voices

### `elevenlabs.voices.get`

`GET /v1/voices/{voice_id}`

Get voice

**Parameters:**

- `voice_id` (required)
- `with_settings`

### `elevenlabs.voices.delete`

`DELETE /v1/voices/{voice_id}`

Delete voice

**Parameters:**

- `voice_id` (required)

### `elevenlabs.voices.update`

`POST /v1/voices/{voice_id}/edit`

Edit voice

**Parameters:**

- `voice_id` (required)
- `name` (required)
- `files`
- `remove_background_noise`
- `description`
- `labels`
- `moderate_metadata`

### `elevenlabs.voices.search`

`GET /v2/voices`

List voices

**Parameters:**

- `next_page_token`
- `page_size`
- `search`
- `sort`
- `sort_direction`
- `voice_type`
- `category`
- `fine_tuning_state`
- `collection_id`
- `gender`
- `age`
- `language`
- `accent`
- `use_cases`
- `min_notice_period_days`
- `include_custom_rates`
- `include_live_moderated`
- `high_quality`
- `include_total_count`
- `voice_ids`

### `elevenlabs.voices.replicate_to_isolated_environment`

`POST /v1/voices/{voice_id}/replicate-to-isolated-environment`

Replicate Voice To Isolated Environment

**Parameters:**

- `voice_id` (required)
- `target_workspace_id` (required)
- `preserve_voice_id`

### `elevenlabs.voices.share`

`POST /v1/voices/add/{public_user_id}/{voice_id}`

Add shared voice

**Parameters:**

- `public_user_id` (required)
- `voice_id` (required)
- `new_name` (required)
- `bookmarked`

### `elevenlabs.voices.find_similar_voices`

`POST /v1/similar-voices`

List similar voices

**Parameters:**

- `audio_file`
- `similarity_threshold`
- `top_k`

### `elevenlabs.voices.get_shared`

`GET /v1/shared-voices`

Get shared voices

**Parameters:**

- `page_size`
- `category`
- `gender`
- `age`
- `accent`
- `language`
- `locale`
- `search`
- `use_cases`
- `descriptives`
- `featured`
- `min_notice_period_days`
- `include_custom_rates`
- `include_live_moderated`
- `reader_app_enabled`
- `owner_id`
- `sort`
- `page`

## Voices Ivc

### `elevenlabs.voices.ivc.create`

`POST /v1/voices/add`

Create voice clone

**Parameters:**

- `name` (required)
- `files` (required)
- `remove_background_noise`
- `description`
- `labels`

## Studio

### `elevenlabs.studio.create_podcast`

`POST /v1/studio/podcasts`

Create Podcast

**Parameters:**

- `safety_identifier`
- `model_id` (required)
- `mode` (required)
- `source` (required)
- `quality_preset`
- `duration_scale`
- `language`
- `intro`
- `outro`
- `instructions_prompt`
- `highlights`
- `callback_url`
- `apply_text_normalization`

## Studio Projects PronunciationDictionaries

### `elevenlabs.studio.projects.pronunciation_dictionaries.create`

`POST /v1/studio/projects/{project_id}/pronunciation-dictionaries`

Create Pronunciation Dictionaries

**Parameters:**

- `project_id` (required)
- `pronunciation_dictionary_locators` (required)
- `invalidate_affected_text`

### `elevenlabs.studio.projects.pronunciation_dictionaries.create_from_file`

`POST /v1/pronunciation-dictionaries/add-from-file`

Create a pronunciation dictionary from a file

**Parameters:**

- `name` (required)
- `file`
- `description`
- `workspace_access`

### `elevenlabs.studio.projects.pronunciation_dictionaries.create_from_rules`

`POST /v1/pronunciation-dictionaries/add-from-rules`

Create a pronunciation dictionary from rules

**Parameters:**

- `rules` (required)
- `name` (required)
- `description`
- `workspace_access`

### `elevenlabs.studio.projects.pronunciation_dictionaries.get`

`GET /v1/pronunciation-dictionaries/{pronunciation_dictionary_id}`

Get pronunciation dictionary

**Parameters:**

- `pronunciation_dictionary_id` (required)

### `elevenlabs.studio.projects.pronunciation_dictionaries.update`

`PATCH /v1/pronunciation-dictionaries/{pronunciation_dictionary_id}`

Update Pronunciation Dictionary

**Parameters:**

- `pronunciation_dictionary_id` (required)
- `archived`
- `name`

### `elevenlabs.studio.projects.pronunciation_dictionaries.download`

`GET /v1/pronunciation-dictionaries/{dictionary_id}/{version_id}/download`

Get pronunciation dictionary by version

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `dictionary_id` (required)
- `version_id` (required)

### `elevenlabs.studio.projects.pronunciation_dictionaries.list`

`GET /v1/pronunciation-dictionaries`

List pronunciation dictionaries

**Parameters:**

- `cursor`
- `page_size`
- `sort`
- `sort_direction`
- `include_archived`

## Studio Projects

### `elevenlabs.studio.projects.list`

`GET /v1/studio/projects`

List Studio Projects

### `elevenlabs.studio.projects.create`

`POST /v1/studio/projects`

Create Studio Project

**Parameters:**

- `name` (required)
- `default_title_voice_id`
- `default_paragraph_voice_id`
- `default_model_id`
- `from_url`
- `from_document`
- `from_content_json`
- `quality_preset`
- `title`
- `author`
- `description`
- `genres`
- `target_audience`
- `language`
- `content_type`
- `original_publication_date`
- `mature_content`
- `isbn_number`
- `acx_volume_normalization`
- `volume_normalization`
- `pronunciation_dictionary_locators`
- `callback_url`
- `fiction`
- `apply_text_normalization`
- `auto_convert`
- `auto_assign_voices`
- `source_type`
- `voice_settings`
- `create_publishing_read`

### `elevenlabs.studio.projects.get`

`GET /v1/studio/projects/{project_id}`

Get Studio Project

**Parameters:**

- `project_id` (required)
- `share_id`

### `elevenlabs.studio.projects.update`

`POST /v1/studio/projects/{project_id}`

Update Studio Project

**Parameters:**

- `project_id` (required)
- `name` (required)
- `default_title_voice_id` (required)
- `default_paragraph_voice_id` (required)
- `title`
- `author`
- `isbn_number`
- `volume_normalization`

### `elevenlabs.studio.projects.delete`

`DELETE /v1/studio/projects/{project_id}`

Delete Studio Project

**Parameters:**

- `project_id` (required)

### `elevenlabs.studio.projects.convert`

`POST /v1/studio/projects/{project_id}/convert`

Convert Studio Project

**Parameters:**

- `project_id` (required)

### `elevenlabs.studio.projects.get_muted_tracks`

`GET /v1/studio/projects/{project_id}/muted-tracks`

Get Project Muted Tracks

**Parameters:**

- `project_id` (required)

## Studio Projects Content

### `elevenlabs.studio.projects.content.update`

`POST /v1/studio/projects/{project_id}/content`

Update Studio Project Content

**Parameters:**

- `project_id` (required)
- `from_url`
- `from_document`
- `from_content_json`
- `auto_convert`

## Studio Projects Snapshots

### `elevenlabs.studio.projects.snapshots.list`

`GET /v1/studio/projects/{project_id}/snapshots`

List Studio Project Snapshots

**Parameters:**

- `project_id` (required)

### `elevenlabs.studio.projects.snapshots.get`

`GET /v1/studio/projects/{project_id}/snapshots/{project_snapshot_id}`

Get Project Snapshot

**Parameters:**

- `project_id` (required)
- `project_snapshot_id` (required)

### `elevenlabs.studio.projects.snapshots.stream`

`POST /v1/studio/projects/{project_id}/snapshots/{project_snapshot_id}/stream`

Stream Studio Project Audio

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `project_id` (required)
- `project_snapshot_id` (required)
- `convert_to_mpeg`

### `elevenlabs.studio.projects.snapshots.stream_archive`

`POST /v1/studio/projects/{project_id}/snapshots/{project_snapshot_id}/archive`

Stream Archive With Studio Project Audio

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `project_id` (required)
- `project_snapshot_id` (required)

### `elevenlabs.studio.projects.snapshots.list`

`GET /v1/studio/projects/{project_id}/chapters/{chapter_id}/snapshots`

List Chapter Snapshots

**Parameters:**

- `project_id` (required)
- `chapter_id` (required)

### `elevenlabs.studio.projects.snapshots.get`

`GET /v1/studio/projects/{project_id}/chapters/{chapter_id}/snapshots/{chapter_snapshot_id}`

Get Chapter Snapshot

**Parameters:**

- `project_id` (required)
- `chapter_id` (required)
- `chapter_snapshot_id` (required)

### `elevenlabs.studio.projects.snapshots.stream`

`POST /v1/studio/projects/{project_id}/chapters/{chapter_id}/snapshots/{chapter_snapshot_id}/stream`

Stream Chapter Audio

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `project_id` (required)
- `chapter_id` (required)
- `chapter_snapshot_id` (required)
- `convert_to_mpeg`

## Studio Projects Chapters

### `elevenlabs.studio.projects.chapters.list`

`GET /v1/studio/projects/{project_id}/chapters`

List Chapters

**Parameters:**

- `project_id` (required)

### `elevenlabs.studio.projects.chapters.create`

`POST /v1/studio/projects/{project_id}/chapters`

Create Chapter

**Parameters:**

- `project_id` (required)
- `name` (required)
- `from_url`

### `elevenlabs.studio.projects.chapters.get`

`GET /v1/studio/projects/{project_id}/chapters/{chapter_id}`

Get Chapter

**Parameters:**

- `project_id` (required)
- `chapter_id` (required)

### `elevenlabs.studio.projects.chapters.update`

`POST /v1/studio/projects/{project_id}/chapters/{chapter_id}`

Update Chapter

**Parameters:**

- `project_id` (required)
- `chapter_id` (required)
- `name`
- `content`

### `elevenlabs.studio.projects.chapters.delete`

`DELETE /v1/studio/projects/{project_id}/chapters/{chapter_id}`

Delete Chapter

**Parameters:**

- `project_id` (required)
- `chapter_id` (required)

### `elevenlabs.studio.projects.chapters.convert`

`POST /v1/studio/projects/{project_id}/chapters/{chapter_id}/convert`

Convert Chapter

**Parameters:**

- `project_id` (required)
- `chapter_id` (required)

## Dubbing Project

### `elevenlabs.dubbing.project.list`

`GET /v1/dubbing/project`

List Dubbing Projects

**Parameters:**

- `cursor`
- `page_size`
- `status`
- `sort_direction`

### `elevenlabs.dubbing.project.create`

`POST /v1/dubbing/project`

Create Dubbing Project

**Parameters:**

- `file`
- `source_url`
- `reference`
- `source_language`
- `model_id`
- `keyterms`
- `webhook_ids`
- `target_language`
- `transcript`

### `elevenlabs.dubbing.project.get`

`GET /v1/dubbing/project/{project_id}`

Get Dubbing Project

**Parameters:**

- `project_id` (required)

### `elevenlabs.dubbing.project.delete`

`DELETE /v1/dubbing/project/{project_id}`

Delete Dubbing Project

**Parameters:**

- `project_id` (required)

## Dubbing Project Language

### `elevenlabs.dubbing.project.language.list`

`GET /v1/dubbing/project/{project_id}/language`

List Dubbing Language Targets

**Parameters:**

- `project_id` (required)
- `cursor`
- `page_size`
- `status`

### `elevenlabs.dubbing.project.language.create`

`POST /v1/dubbing/project/{project_id}/language`

Create Dubbing Language Target

**Parameters:**

- `project_id` (required)
- `target_language` (required)
- `voice_settings`
- `translations`

### `elevenlabs.dubbing.project.language.get`

`GET /v1/dubbing/project/{project_id}/language/{language_id}`

Get Dubbing Language Target

**Parameters:**

- `project_id` (required)
- `language_id` (required)

### `elevenlabs.dubbing.project.language.delete`

`DELETE /v1/dubbing/project/{project_id}/language/{language_id}`

Delete Dubbing Language Target

**Parameters:**

- `project_id` (required)
- `language_id` (required)

## Dubbing Project Transcript

### `elevenlabs.dubbing.project.transcript.get`

`GET /v1/dubbing/project/{project_id}/transcript`

Get Dubbing Transcript

**Parameters:**

- `project_id` (required)

### `elevenlabs.dubbing.project.transcript.update_segment`

`PATCH /v1/dubbing/project/{project_id}/transcript/segment/{segment_id}`

Update Dubbing Transcript Segment

**Parameters:**

- `project_id` (required)
- `segment_id` (required)
- `text`
- `speaker_id`
- `start_s`
- `end_s`

### `elevenlabs.dubbing.project.transcript.delete_segment`

`DELETE /v1/dubbing/project/{project_id}/transcript/segment/{segment_id}`

Delete Dubbing Transcript Segment

**Parameters:**

- `project_id` (required)
- `segment_id` (required)

### `elevenlabs.dubbing.project.transcript.update_segments`

`PATCH /v1/dubbing/project/{project_id}/transcript/segments`

Update Dubbing Transcript Segments

**Parameters:**

- `project_id` (required)
- `segments` (required)

### `elevenlabs.dubbing.project.transcript.create_segment`

`POST /v1/dubbing/project/{project_id}/transcript/segment`

Add Dubbing Transcript Segment

**Parameters:**

- `project_id` (required)
- `text` (required)
- `speaker_id` (required)
- `start_s` (required)
- `end_s` (required)

### `elevenlabs.dubbing.project.transcript.get`

`GET /v1/dubbing/project/{project_id}/language/{language_id}/transcript`

Get Dubbing Target Transcript

**Parameters:**

- `project_id` (required)
- `language_id` (required)

### `elevenlabs.dubbing.project.transcript.update_segment`

`PATCH /v1/dubbing/project/{project_id}/language/{language_id}/transcript/segment/{segment_id}`

Update Dubbing Target Transcript Segment

**Parameters:**

- `project_id` (required)
- `language_id` (required)
- `segment_id` (required)
- `translation`

### `elevenlabs.dubbing.project.transcript.update_segments`

`PATCH /v1/dubbing/project/{project_id}/language/{language_id}/transcript/segments`

Update Dubbing Target Transcript Segments

**Parameters:**

- `project_id` (required)
- `language_id` (required)
- `segments` (required)

### `elevenlabs.dubbing.project.transcript.regenerate`

`POST /v1/dubbing/project/{project_id}/language/{language_id}/transcript/regenerate`

Regenerate Dubbing Target

**Parameters:**

- `project_id` (required)
- `language_id` (required)

## Dubbing

### `elevenlabs.dubbing.list`

`GET /v1/dubbing`

List Dubs

**Parameters:**

- `cursor`
- `page_size`
- `dubbing_status`
- `dubbing_statuses`
- `dubbing_models`
- `target_language_codes`
- `creation_sources`
- `filter_by_creator`
- `order_by`
- `order_direction`

### `elevenlabs.dubbing.create`

`POST /v1/dubbing`

Dub a video or audio file

**Parameters:**

- `file`
- `csv_file`
- `foreground_audio_file`
- `background_audio_file`
- `name`
- `source_url`
- `source_lang`
- `target_lang`
- `target_accent`
- `num_speakers`
- `watermark`
- `start_time`
- `end_time`
- `highest_resolution`
- `drop_background_audio`
- `use_profanity_filter`
- `dubbing_studio`
- `disable_voice_cloning`
- `mode`
- `csv_fps`

### `elevenlabs.dubbing.get`

`GET /v1/dubbing/{dubbing_id}`

Get dubbing

**Parameters:**

- `dubbing_id` (required)

### `elevenlabs.dubbing.delete`

`DELETE /v1/dubbing/{dubbing_id}`

Delete dubbing

**Parameters:**

- `dubbing_id` (required)

## Dubbing Transcripts

### `elevenlabs.dubbing.transcripts.get`

`GET /v1/dubbing/{dubbing_id}/transcripts/{language_code}/format/{format_type}`

Retrieve A Transcript

**Parameters:**

- `dubbing_id` (required)
- `language_code` (required)
- `format_type` (required)

### `elevenlabs.dubbing.transcripts.get`

`GET /v1/speech-to-text/transcripts/{transcription_id}`

Get Transcript By Id

**Parameters:**

- `transcription_id` (required)

### `elevenlabs.dubbing.transcripts.delete`

`DELETE /v1/speech-to-text/transcripts/{transcription_id}`

Delete Transcript By Id

**Parameters:**

- `transcription_id` (required)

## Models

### `elevenlabs.models.list`

`GET /v1/models`

List models

## AudioNative

### `elevenlabs.audio_native.create`

`POST /v1/audio-native`

Create audio native project

**Parameters:**

- `name` (required)
- `image`
- `author`
- `title`
- `small`
- `text_color`
- `background_color`
- `sessionization`
- `voice_id`
- `model_id`
- `file`
- `auto_convert`
- `apply_text_normalization`
- `pronunciation_dictionary_locators`

### `elevenlabs.audio_native.get_settings`

`GET /v1/audio-native/{project_id}/settings`

Get Audio Native Project Settings

**Parameters:**

- `project_id` (required)

### `elevenlabs.audio_native.update`

`POST /v1/audio-native/{project_id}/content`

Update audio native project

**Parameters:**

- `project_id` (required)
- `file`
- `auto_convert`
- `auto_publish`

### `elevenlabs.audio_native.update_content_from_url`

`POST /v1/audio-native/content`

Update Audio-Native Content From Url

**Parameters:**

- `url` (required)
- `author`
- `title`

## PronunciationDictionaries Rules

### `elevenlabs.pronunciation_dictionaries.rules.set`

`POST /v1/pronunciation-dictionaries/{pronunciation_dictionary_id}/set-rules`

Set pronunciation dictionary rules

**Parameters:**

- `pronunciation_dictionary_id` (required)
- `rules` (required)

### `elevenlabs.pronunciation_dictionaries.rules.add`

`POST /v1/pronunciation-dictionaries/{pronunciation_dictionary_id}/add-rules`

Add pronunciation dictionary rules

**Parameters:**

- `pronunciation_dictionary_id` (required)
- `rules` (required)

### `elevenlabs.pronunciation_dictionaries.rules.remove`

`POST /v1/pronunciation-dictionaries/{pronunciation_dictionary_id}/remove-rules`

Remove pronunciation dictionary rules

**Parameters:**

- `pronunciation_dictionary_id` (required)
- `rule_strings` (required)

## Workspaces APIKeys

### `elevenlabs.workspaces.api_keys.disable`

`POST /v1/workspaces/api-keys/disable`

Disable API key

**Parameters:**

- `api_key_name` (required)

### `elevenlabs.workspaces.api_keys.list`

`GET /v1/service-accounts/{service_account_user_id}/api-keys`

Get API keys

**Parameters:**

- `service_account_user_id` (required)

### `elevenlabs.workspaces.api_keys.create`

`POST /v1/service-accounts/{service_account_user_id}/api-keys`

Create API key

**Parameters:**

- `service_account_user_id` (required)
- `name` (required)
- `permissions` (required)
- `character_limit`
- `allowed_ips`
- `third_party_disable_allowed`
- `tts_concurrency_limit`
- `dubbing_concurrency_limit`
- `music_concurrency_limit`
- `expires_at_unix`

### `elevenlabs.workspaces.api_keys.update`

`PATCH /v1/service-accounts/{service_account_user_id}/api-keys/{api_key_id}`

Update API key

**Parameters:**

- `service_account_user_id` (required)
- `api_key_id` (required)
- `is_enabled`
- `name`
- `permissions`
- `character_limit`
- `allowed_ips`
- `third_party_disable_allowed`
- `tts_concurrency_limit`
- `dubbing_concurrency_limit`
- `music_concurrency_limit`
- `expires_at_unix`

### `elevenlabs.workspaces.api_keys.delete`

`DELETE /v1/service-accounts/{service_account_user_id}/api-keys/{api_key_id}`

Delete API key

**Parameters:**

- `service_account_user_id` (required)
- `api_key_id` (required)

### `elevenlabs.workspaces.api_keys.disable`

`POST /v1/service-accounts/{service_account_user_id}/api-keys/{api_key_id}/disable`

Disable Service Account Api Key

**Parameters:**

- `service_account_user_id` (required)
- `api_key_id` (required)

## Workspace

### `elevenlabs.workspace.set_third_party_disabling_policy`

`POST /v1/workspaces/api-keys/third-party-disabling`

Set Workspace Third-Party Disabling Policy

**Parameters:**

- `third_party_disable_allowed`

## Workspace AuditLogs

### `elevenlabs.workspace.audit_logs.list`

`GET /v1/workspace/audit-logs`

Get Workspace Audit Logs

**Parameters:**

- `limit`
- `cursor`
- `time_from_unix_ms`
- `time_to_unix_ms`
- `actor_uid`
- `class_name`
- `activity_name`

## Workspace AuthConnections

### `elevenlabs.workspace.auth_connections.list`

`GET /v1/workspace/auth-connections`

Get Workspace Auth Connections

### `elevenlabs.workspace.auth_connections.create`

`POST /v1/workspace/auth-connections`

Create Workspace Auth Connection

### `elevenlabs.workspace.auth_connections.update`

`PATCH /v1/workspace/auth-connections/{auth_connection_id}`

Update Workspace Auth Connection

**Parameters:**

- `auth_connection_id` (required)

### `elevenlabs.workspace.auth_connections.delete`

`DELETE /v1/workspace/auth-connections/{auth_connection_id}`

Delete Workspace Auth Connection

**Parameters:**

- `auth_connection_id` (required)

## ServiceAccounts

### `elevenlabs.service_accounts.list`

`GET /v1/service-accounts`

Get service accounts

### `elevenlabs.service_accounts.create`

`POST /v1/service-accounts`

Create Service Account

**Parameters:**

- `name` (required)
- `default_sharing_groups`

## Workspace Groups

### `elevenlabs.workspace.groups.list`

`GET /v1/workspace/groups`

List workspace groups

### `elevenlabs.workspace.groups.search`

`GET /v1/workspace/groups/search`

Search user group

**Parameters:**

- `name` (required)

## Workspace Groups Members

### `elevenlabs.workspace.groups.members.remove`

`POST /v1/workspace/groups/{group_id}/members/remove`

Remove member from user group

**Parameters:**

- `group_id` (required)
- `email` (required)

### `elevenlabs.workspace.groups.members.add`

`POST /v1/workspace/groups/{group_id}/members`

Add member to user group

**Parameters:**

- `group_id` (required)
- `email` (required)

### `elevenlabs.workspace.groups.members.list`

`GET /v1/workspace/members`

Get Workspace Members

### `elevenlabs.workspace.groups.members.update`

`POST /v1/workspace/members`

Update member

**Parameters:**

- `email` (required)
- `is_locked`
- `workspace_role`
- `workspace_seat_type`
- `allow_downgrade_to_basic_seat`

### `elevenlabs.workspace.groups.members.update_usage_limit`

`PUT /v1/workspace/members/{user_id}/usage-limit`

Update Member Usage Limit

**Parameters:**

- `user_id` (required)
- `usage_limit` (required)

## Workspace Invites

### `elevenlabs.workspace.invites.create`

`POST /v1/workspace/invites/add`

Invite user

**Parameters:**

- `email` (required)
- `workspace_permission`
- `seat_type`
- `group_ids`
- `usage_limit`

### `elevenlabs.workspace.invites.create_batch`

`POST /v1/workspace/invites/add-bulk`

Invite Multiple Users

**Parameters:**

- `emails` (required)
- `seat_type`
- `group_ids`
- `usage_limit`

### `elevenlabs.workspace.invites.delete`

`DELETE /v1/workspace/invites`

Delete invite

**Parameters:**

- `email` (required)

## Workspace Resources

### `elevenlabs.workspace.resources.get`

`GET /v1/workspace/resources/{resource_id}`

Get Resource

**Parameters:**

- `resource_id` (required)
- `resource_type` (required)

### `elevenlabs.workspace.resources.share`

`POST /v1/workspace/resources/{resource_id}/share`

Share Workspace Resource

**Parameters:**

- `resource_id` (required)
- `role` (required)
- `resource_type` (required)
- `user_email`
- `group_id`
- `workspace_api_key_id`

### `elevenlabs.workspace.resources.unshare`

`POST /v1/workspace/resources/{resource_id}/unshare`

Unshare Workspace Resource

**Parameters:**

- `resource_id` (required)
- `resource_type` (required)
- `user_email`
- `group_id`
- `workspace_api_key_id`

## Webhooks

### `elevenlabs.webhooks.list`

`GET /v1/workspace/webhooks`

List Workspace Webhooks

**Parameters:**

- `include_usages`

### `elevenlabs.webhooks.create`

`POST /v1/workspace/webhooks`

Create Workspace Webhook

**Parameters:**

- `settings` (required)

### `elevenlabs.webhooks.update`

`PATCH /v1/workspace/webhooks/{webhook_id}`

Update Workspace Webhook

**Parameters:**

- `webhook_id` (required)
- `is_disabled` (required)
- `name` (required)
- `retry_enabled`
- `request_headers`
- `events`

### `elevenlabs.webhooks.delete`

`DELETE /v1/workspace/webhooks/{webhook_id}`

Delete Workspace Webhook

**Parameters:**

- `webhook_id` (required)

## Music

### `elevenlabs.music.video_to_music`

`POST /v1/music/video-to-music`

Video To Music

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `output_format`
- `enable_logging`
- `videos` (required)
- `description`
- `tags`
- `model_id`
- `add_sfx`
- `separate_tracks`
- `use_audio_as_reference`
- `sign_with_c2pa`

### `elevenlabs.music.compose`

`POST /v1/music`

Compose Music

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `output_format`
- `enable_logging`
- `prompt`
- `composition_plan`
- `music_length_ms`
- `model_id`
- `seed`
- `force_instrumental`
- `finetune_id`
- `respect_sections_durations`
- `store_for_inpainting`
- `sign_with_c2pa`

### `elevenlabs.music.compose_detailed`

`POST /v1/music/detailed`

Compose Music With A Detailed Response

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `output_format`
- `enable_logging`
- `prompt`
- `composition_plan`
- `music_length_ms`
- `model_id`
- `seed`
- `force_instrumental`
- `finetune_id`
- `respect_sections_durations`
- `store_for_inpainting`
- `with_timestamps`
- `with_waveform_visual`
- `sign_with_c2pa`

### `elevenlabs.music.compose_detailed_stream`

`POST /v1/music/detailed/stream`

Stream Composed Music With A Detailed Response

**Parameters:**

- `output_format`
- `enable_logging`
- `prompt`
- `composition_plan`
- `music_length_ms`
- `model_id`
- `seed`
- `force_instrumental`
- `finetune_id`
- `store_for_inpainting`
- `with_timestamps`
- `with_waveform_visual`

### `elevenlabs.music.stream`

`POST /v1/music/stream`

Stream Composed Music

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `output_format`
- `enable_logging`
- `prompt`
- `composition_plan`
- `music_length_ms`
- `model_id`
- `seed`
- `force_instrumental`
- `finetune_id`
- `store_for_inpainting`

### `elevenlabs.music.upload`

`POST /v1/music/upload`

Upload Music

**Parameters:**

- `file` (required)
- `extract_composition_plan`
- `with_timestamps`
- `with_waveform_visual`

### `elevenlabs.music.separate_stems`

`POST /v1/music/stem-separation`

Stem Separation

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `output_format`
- `enable_logging`
- `file` (required)
- `stem_variation_id`
- `sign_with_c2pa`

## SpeechToText

### `elevenlabs.speech_to_text.convert`

`POST /v1/speech-to-text`

Create transcript

**Parameters:**

- `token`
- `enable_logging`
- `model_id` (required)
- `file`
- `language_code`
- `secondary_language_codes`
- `numbers_format`
- `transcript_edit`
- `tag_audio_events`
- `num_speakers`
- `timestamps_granularity`
- `diarize`
- `diarization_threshold`
- `additional_formats`
- `file_format`
- `source_url`
- `webhook`
- `webhook_id`
- `temperature`
- `seed`
- `use_multi_channel`
- `multichannel_output_style`
- `webhook_metadata`
- `entity_detection`
- `no_verbatim`
- `use_speaker_library`
- `detect_speaker_roles`
- `entity_redaction`
- `entity_redaction_mode`
- `keyterms`

## Tokens SingleUse

### `elevenlabs.tokens.single_use.create`

`POST /v1/single-use-token/{token_type}`

Create Single Use Token

**Parameters:**

- `token_type` (required)

## ForcedAlignment

### `elevenlabs.forced_alignment.create`

`POST /v1/forced-alignment`

Create Forced Alignment

**Parameters:**

- `file` (required)
- `text` (required)

## Agents Conversations

### `elevenlabs.agents.conversations.get_signed_url`

`GET /v1/convai/conversation/get-signed-url`

Get Signed Url

**Parameters:**

- `agent_id` (required)
- `include_conversation_id`
- `branch_id`
- `version_id`
- `environment`
- `debug_events_request`

### `elevenlabs.agents.conversations.get_webrtc_token`

`GET /v1/convai/conversation/token`

Get a webrtc token to start a conversation with an agent that requires authorization

**Parameters:**

- `agent_id` (required)
- `participant_name`
- `branch_id`
- `version_id`
- `environment`
- `debug_events_request`

### `elevenlabs.agents.conversations.list`

`GET /v1/convai/conversations`

List conversations

**Parameters:**

- `cursor`
- `agent_id`
- `visited_agent_ids`
- `visited_agent_branch_ids`
- `triggered_procedure_ids`
- `call_successful`
- `call_start_before_unix`
- `call_start_after_unix`
- `call_duration_min_secs`
- `call_duration_max_secs`
- `rating_max`
- `rating_min`
- `has_feedback_comment`
- `user_id`
- `evaluation_params`
- `data_collection_params`
- `dynamic_variable_params`
- `data_collection_filter`
- `dynamic_variable_filter`
- `data_collection_ids`
- `evaluation_criteria_ids`
- `tool_names`
- `tool_names_successful`
- `tool_names_errored`
- `tool_ids`
- `tool_ids_successful`
- `tool_ids_errored`
- `include_invalid_tool_calls`
- `main_languages`
- `phone_number_ids`
- `whatsapp_phone_number_ids`
- `page_size`
- `summary_mode`
- `search`
- `conversation_initiation_source`
- `text_only`
- `conversation_product_type`
- `branch_id`
- `version_id`
- `parent_conversation_id`
- `topic_ids`
- `exclude_statuses`
- `tag_ids`
- `workflow_node_entered_id`
- `termination_reasons`
- `guardrail_types`
- `custom_guardrail_names`
- `sort_direction`

### `elevenlabs.agents.conversations.resolve`

`GET /v1/convai/conversations/resolve`

Resolve Conversation Reference

**Parameters:**

- `agent_id` (required)
- `reference` (required)

### `elevenlabs.agents.conversations.get`

`GET /v1/convai/conversations/{conversation_id}`

Get Conversation Details

**Parameters:**

- `conversation_id` (required)
- `format`

### `elevenlabs.agents.conversations.delete`

`DELETE /v1/convai/conversations/{conversation_id}`

Delete Conversation

**Parameters:**

- `conversation_id` (required)

### `elevenlabs.agents.conversations.get_summary`

`GET /v1/convai/conversations/{conversation_id}/summary`

Get Conversation Summary

**Parameters:**

- `conversation_id` (required)
- `max_messages`

### `elevenlabs.agents.conversations.get_sip_messages`

`GET /v1/convai/conversations/{conversation_id}/sip-messages`

Get Sip Messages For A Conversation

**Parameters:**

- `conversation_id` (required)
- `page_size`
- `cursor`

## Agents Twilio

### `elevenlabs.agents.twilio.outbound_call`

`POST /v1/convai/twilio/outbound-call`

Handle An Outbound Call Via Twilio

**Parameters:**

- `agent_id` (required)
- `agent_phone_number_id` (required)
- `to_number` (required)
- `conversation_initiation_client_data`
- `call_recording_enabled`
- `telephony_call_config`

### `elevenlabs.agents.twilio.register_call`

`POST /v1/convai/twilio/register-call`

Register A Twilio Call And Return Twiml

**Parameters:**

- `agent_id` (required)
- `from_number` (required)
- `to_number` (required)
- `direction`
- `conversation_initiation_client_data`

## Agents Exotel

### `elevenlabs.agents.exotel.outbound_call`

`POST /v1/convai/exotel/outbound-call`

Handle An Outbound Call Via Exotel

**Parameters:**

- `agent_id` (required)
- `agent_phone_number_id` (required)
- `to_number` (required)
- `conversation_initiation_client_data`
- `telephony_call_config`

## Agents Whatsapp

### `elevenlabs.agents.whatsapp.outbound_call`

`POST /v1/convai/whatsapp/outbound-call`

Make An Outbound Call Via Whatsapp

**Parameters:**

- `whatsapp_phone_number_id` (required)
- `whatsapp_user_id` (required)
- `whatsapp_call_permission_request_template_name` (required)
- `whatsapp_call_permission_request_template_language_code` (required)
- `agent_id` (required)
- `conversation_initiation_client_data`

### `elevenlabs.agents.whatsapp.outbound_message`

`POST /v1/convai/whatsapp/outbound-message`

Send An Outbound Message Via Whatsapp

**Parameters:**

- `whatsapp_phone_number_id` (required)
- `whatsapp_user_id` (required)
- `template_name` (required)
- `template_language_code` (required)
- `template_params` (required)
- `agent_id` (required)
- `conversation_initiation_client_data`

## Agents

### `elevenlabs.agents.create`

`POST /v1/convai/agents/create`

Create agent

**Parameters:**

- `enable_versioning`
- `conversation_config` (required)
- `platform_settings`
- `workflow`
- `name`
- `tags`

### `elevenlabs.agents.get`

`GET /v1/convai/agents/{agent_id}`

Get agent

**Parameters:**

- `agent_id` (required)
- `version_id`
- `branch_id`
- `include_procedure_generated_workflow_elements`

### `elevenlabs.agents.update`

`PATCH /v1/convai/agents/{agent_id}`

Update agent

**Parameters:**

- `agent_id` (required)
- `enable_versioning_if_not_enabled`
- `branch_id`
- `include_procedure_generated_workflow_elements`
- `conversation_config`
- `platform_settings`
- `workflow`
- `name`
- `tags`
- `version_description`
- `procedures`

### `elevenlabs.agents.delete`

`DELETE /v1/convai/agents/{agent_id}`

Delete agent

**Parameters:**

- `agent_id` (required)
- `force`

### `elevenlabs.agents.list`

`GET /v1/convai/agents`

List Agents

**Parameters:**

- `page_size`
- `search`
- `archived`
- `show_only_owned_agents`
- `created_by_user_id`
- `tags`
- `sort_direction`
- `sort_by`
- `cursor`

### `elevenlabs.agents.duplicate`

`POST /v1/convai/agents/{agent_id}/duplicate`

Duplicate Agent

**Parameters:**

- `agent_id` (required)
- `name`

### `elevenlabs.agents.run_tests`

`POST /v1/convai/agents/{agent_id}/run-tests`

Run Tests On The Agent

**Parameters:**

- `agent_id` (required)
- `name`
- `tests` (required)
- `agent_config_override`
- `branch_id`
- `repeat_count`

### `elevenlabs.agents.rag_index_overview`

`GET /v1/convai/knowledge-base/rag-index`

Get Rag Index Overview.

### `elevenlabs.agents.get_document_rag_indexes`

`GET /v1/convai/knowledge-base/{documentation_id}/rag-index`

Get Rag Indexes Of The Specified Knowledgebase Document.

**Parameters:**

- `documentation_id` (required)

### `elevenlabs.agents.delete_document_rag_index`

`DELETE /v1/convai/knowledge-base/{documentation_id}/rag-index/{rag_index_id}`

Delete Rag Index.

**Parameters:**

- `documentation_id` (required)
- `rag_index_id` (required)

## Agents Summaries

### `elevenlabs.agents.summaries.get`

`GET /v1/convai/agents/summaries`

Get Agent Summaries

**Parameters:**

- `agent_ids` (required)

### `elevenlabs.agents.summaries.get`

`GET /v1/convai/knowledge-base/summaries`

Get Knowledge Base Summaries By Ids

**Parameters:**

- `document_ids` (required)

## Agents Widget

### `elevenlabs.agents.widget.get`

`GET /v1/convai/agents/{agent_id}/widget`

Get Agent Widget Config

**Parameters:**

- `agent_id` (required)
- `conversation_signature`

## Agents Link

### `elevenlabs.agents.link.get`

`GET /v1/convai/agents/{agent_id}/link`

Get Shareable Agent Link

**Parameters:**

- `agent_id` (required)

## Agents Widget Avatar

### `elevenlabs.agents.widget.avatar.create`

`POST /v1/convai/agents/{agent_id}/avatar`

Post Agent Avatar

**Parameters:**

- `agent_id` (required)
- `avatar_file` (required)

## Agents HoldAudio

### `elevenlabs.agents.hold_audio.create`

`POST /v1/convai/agents/{agent_id}/hold-audio`

Post Agent Hold Audio

**Parameters:**

- `agent_id` (required)
- `hold_audio_file` (required)

### `elevenlabs.agents.hold_audio.delete`

`DELETE /v1/convai/agents/{agent_id}/hold-audio`

Delete Agent Hold Audio

**Parameters:**

- `agent_id` (required)

## Agents KnowledgeBase

### `elevenlabs.agents.knowledge_base.size`

`GET /v1/convai/agent/{agent_id}/knowledge-base/size`

Returns The Size Of The Agent'S Knowledge Base

**Parameters:**

- `agent_id` (required)

### `elevenlabs.agents.knowledge_base.list`

`GET /v1/convai/knowledge-base`

Get Knowledge Base List

**Parameters:**

- `page_size`
- `search`
- `show_only_owned_documents`
- `created_by_user_id`
- `types`
- `parent_folder_id`
- `ancestor_folder_id`
- `folders_first`
- `sort_direction`
- `sort_by`
- `cursor`

### `elevenlabs.agents.knowledge_base.get_or_create_rag_indexes`

`POST /v1/convai/knowledge-base/rag-index`

Compute Rag Indexes In Batch

**Parameters:**

- `items` (required)

### `elevenlabs.agents.knowledge_base.search`

`GET /v1/convai/knowledge-base/search`

Search Knowledge Base Content

**Parameters:**

- `query` (required)
- `page_size`
- `types`
- `cursor`

## Agents LlmUsage

### `elevenlabs.agents.llm_usage.calculate_for_agent`

`POST /v1/convai/agent/{agent_id}/llm-usage/calculate`

Calculate Expected Llm Usage For An Agent

**Parameters:**

- `agent_id` (required)
- `prompt_length`
- `number_of_pages`
- `rag_enabled`
- `service_tier`

### `elevenlabs.agents.llm_usage.calculate`

`POST /v1/convai/llm-usage/calculate`

Calculate Expected Llm Usage

**Parameters:**

- `prompt_length` (required)
- `number_of_pages` (required)
- `rag_enabled` (required)
- `service_tier`

## Agents Tests

### `elevenlabs.agents.tests.create`

`POST /v1/convai/agent-testing/create`

Create Agent Response Test

### `elevenlabs.agents.tests.move`

`POST /v1/convai/agent-testing/bulk-move`

Bulk Move Tests To Folder

**Parameters:**

- `entity_ids` (required)
- `move_to`

### `elevenlabs.agents.tests.get`

`GET /v1/convai/agent-testing/{test_id}`

Get Agent Response Test By Id

**Parameters:**

- `test_id` (required)

### `elevenlabs.agents.tests.update`

`PUT /v1/convai/agent-testing/{test_id}`

Update Agent Response Test

**Parameters:**

- `test_id` (required)

### `elevenlabs.agents.tests.delete`

`DELETE /v1/convai/agent-testing/{test_id}`

Delete Agent Response Test

**Parameters:**

- `test_id` (required)

### `elevenlabs.agents.tests.summaries`

`POST /v1/convai/agent-testing/summaries`

Get Agent Response Test Summaries By Ids

**Parameters:**

- `test_ids` (required)

### `elevenlabs.agents.tests.list`

`GET /v1/convai/agent-testing`

List Agent Response Tests

**Parameters:**

- `cursor`
- `page_size`
- `search`
- `parent_folder_id`
- `types`
- `include_folders`
- `sort_mode`
- `sharing_mode`
- `created_by_user_id`

## Agents Tests Folders

### `elevenlabs.agents.tests.folders.create`

`POST /v1/convai/agent-testing/folders`

Create Agent Test Folder

**Parameters:**

- `name` (required)
- `parent_folder_id`

### `elevenlabs.agents.tests.folders.get`

`GET /v1/convai/agent-testing/folders/{folder_id}`

Get Agent Test Folder By Id

**Parameters:**

- `folder_id` (required)

### `elevenlabs.agents.tests.folders.update`

`PATCH /v1/convai/agent-testing/folders/{folder_id}`

Update Agent Test Folder

**Parameters:**

- `folder_id` (required)
- `name` (required)

### `elevenlabs.agents.tests.folders.delete`

`DELETE /v1/convai/agent-testing/folders/{folder_id}`

Delete Agent Test Folder

**Parameters:**

- `folder_id` (required)
- `force`

## Agents Tests Invocations

### `elevenlabs.agents.tests.invocations.list`

`GET /v1/convai/test-invocations`

List Test Invocations

**Parameters:**

- `agent_id`
- `branch_id`
- `created_by_user_id`
- `test_id`
- `start_time`
- `end_time`
- `version_id`
- `page_size`
- `search`
- `cursor`

### `elevenlabs.agents.tests.invocations.get`

`GET /v1/convai/test-invocations/{test_invocation_id}`

Get Test Invocation

**Parameters:**

- `test_invocation_id` (required)

### `elevenlabs.agents.tests.invocations.update`

`PATCH /v1/convai/test-invocations/{test_invocation_id}`

Update Test Invocation

**Parameters:**

- `test_invocation_id` (required)
- `name` (required)

### `elevenlabs.agents.tests.invocations.cancel`

`POST /v1/convai/test-invocations/{test_invocation_id}/cancel`

Cancel Test Invocation

**Parameters:**

- `test_invocation_id` (required)

### `elevenlabs.agents.tests.invocations.resubmit`

`POST /v1/convai/test-invocations/{test_invocation_id}/resubmit`

Resubmit Tests

**Parameters:**

- `test_invocation_id` (required)
- `test_run_ids` (required)
- `agent_config_override`
- `agent_id` (required)
- `branch_id`

## Agents Users

### `elevenlabs.agents.users.list`

`GET /v1/convai/users`

Get Conversation Users

**Parameters:**

- `agent_id`
- `branch_id`
- `call_start_before_unix`
- `call_start_after_unix`
- `search`
- `page_size`
- `sort_by`
- `sort_direction`
- `cursor`

## Agents Conversations Files

### `elevenlabs.agents.conversations.files.get`

`GET /v1/convai/conversations/{conversation_id}/files/{file_id}`

Get Conversation File

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `conversation_id` (required)
- `file_id` (required)

### `elevenlabs.agents.conversations.files.delete`

`DELETE /v1/convai/conversations/{conversation_id}/files/{file_id}`

Delete File Upload

**Parameters:**

- `file_id` (required)
- `conversation_id` (required)

### `elevenlabs.agents.conversations.files.create`

`POST /v1/convai/conversations/{conversation_id}/files`

Upload File

**Parameters:**

- `conversation_id` (required)
- `file` (required)

## Agents Conversations Feedback

### `elevenlabs.agents.conversations.feedback.create`

`POST /v1/convai/conversations/{conversation_id}/feedback`

Send Conversation Feedback

**Parameters:**

- `conversation_id` (required)
- `feedback`

## Agents Conversations Messages

### `elevenlabs.agents.conversations.messages.text_search`

`GET /v1/convai/conversations/messages/text-search`

Text Search Conversation Messages

**Parameters:**

- `text_query` (required)
- `agent_id`
- `visited_agent_ids`
- `visited_agent_branch_ids`
- `triggered_procedure_ids`
- `call_successful`
- `call_start_before_unix`
- `call_start_after_unix`
- `call_duration_min_secs`
- `call_duration_max_secs`
- `rating_max`
- `rating_min`
- `has_feedback_comment`
- `user_id`
- `evaluation_params`
- `data_collection_params`
- `dynamic_variable_params`
- `tool_names`
- `tool_names_successful`
- `tool_names_errored`
- `tool_ids`
- `tool_ids_successful`
- `tool_ids_errored`
- `include_invalid_tool_calls`
- `main_languages`
- `phone_number_ids`
- `whatsapp_phone_number_ids`
- `exclude_statuses`
- `termination_reasons`
- `page_size`
- `summary_mode`
- `conversation_initiation_source`
- `text_only`
- `conversation_product_type`
- `branch_id`
- `version_id`
- `topic_ids`
- `sort_by`
- `cursor`

### `elevenlabs.agents.conversations.messages.search`

`GET /v1/convai/conversations/messages/smart-search`

Smart Search Conversation Messages

**Parameters:**

- `text_query` (required)
- `agent_id`
- `branch_id`
- `page_size`
- `cursor`

## Agents Conversations Tags

### `elevenlabs.agents.conversations.tags.assign`

`POST /v1/convai/conversations/{conversation_id}/tags`

Assign Conversation Tags

**Parameters:**

- `conversation_id` (required)
- `tag_ids` (required)

### `elevenlabs.agents.conversations.tags.unassign`

`DELETE /v1/convai/conversations/{conversation_id}/tags/{tag_id}`

Unassign Conversation Tag

**Parameters:**

- `conversation_id` (required)
- `tag_id` (required)

### `elevenlabs.agents.conversations.tags.list`

`GET /v1/convai/tags`

List Conversation Tags

**Parameters:**

- `page_size`
- `cursor`

### `elevenlabs.agents.conversations.tags.create`

`POST /v1/convai/tags`

Create Conversation Tag

**Parameters:**

- `title` (required)
- `description`

### `elevenlabs.agents.conversations.tags.get`

`GET /v1/convai/tags/{tag_id}`

Get Conversation Tag

**Parameters:**

- `tag_id` (required)

### `elevenlabs.agents.conversations.tags.update`

`PATCH /v1/convai/tags/{tag_id}`

Update Conversation Tag

**Parameters:**

- `tag_id` (required)
- `title`
- `description`

### `elevenlabs.agents.conversations.tags.delete`

`DELETE /v1/convai/tags/{tag_id}`

Delete Conversation Tag

**Parameters:**

- `tag_id` (required)

## Agents TriageTickets

### `elevenlabs.agents.triage_tickets.list`

`GET /v1/convai/agents/{agent_id}/triage-tickets`

List Agent Conversation Tickets

**Parameters:**

- `agent_id` (required)
- `page_size`
- `conversation_id`
- `status`
- `sources`
- `priorities`
- `sort_by`
- `owner_user_id`
- `assignee_user_id`
- `issue_type`
- `label`
- `merged_into_ticket_id`
- `search`
- `cursor`

### `elevenlabs.agents.triage_tickets.create_manual`

`POST /v1/convai/agents/{agent_id}/triage-tickets`

Create Manual Agent Ticket

**Parameters:**

- `agent_id` (required)
- `title`
- `qa_comment` (required)
- `priority`

### `elevenlabs.agents.triage_tickets.list_for_workspace`

`GET /v1/convai/triage-tickets`

List Workspace Conversation Tickets

**Parameters:**

- `page_size`
- `agent_id`
- `status`
- `sources`
- `priorities`
- `sort_by`
- `owner_user_id`
- `assignee_user_id`
- `issue_type`
- `label`
- `merged_into_ticket_id`
- `search`
- `cursor`

### `elevenlabs.agents.triage_tickets.create`

`POST /v1/convai/triage-tickets`

Create Agent Conversation Ticket

**Parameters:**

- `conversation_id` (required)
- `title`
- `qa_comment`
- `turn_comments`
- `priority`

### `elevenlabs.agents.triage_tickets.list_assignable_users`

`GET /v1/convai/agents/{agent_id}/triage-tickets/assignable-users`

Get Agent Conversation Ticket Assignable Users

**Parameters:**

- `agent_id` (required)

### `elevenlabs.agents.triage_tickets.get`

`GET /v1/convai/triage-tickets/{agentqa_ticket_id}`

Get Agent Conversation Ticket

**Parameters:**

- `agentqa_ticket_id` (required)

### `elevenlabs.agents.triage_tickets.update`

`PATCH /v1/convai/triage-tickets/{agentqa_ticket_id}`

Update Agent Conversation Ticket

**Parameters:**

- `agentqa_ticket_id` (required)
- `title`
- `qa_comment`
- `status`
- `assignee_user_id`
- `priority`

### `elevenlabs.agents.triage_tickets.delete`

`DELETE /v1/convai/triage-tickets/{agentqa_ticket_id}`

Delete Agent Conversation Ticket

**Parameters:**

- `agentqa_ticket_id` (required)

### `elevenlabs.agents.triage_tickets.add_comment`

`POST /v1/convai/triage-tickets/{agentqa_ticket_id}/comments`

Add Comment To Agent Conversation Ticket

**Parameters:**

- `agentqa_ticket_id` (required)
- `comment` (required)

### `elevenlabs.agents.triage_tickets.merge`

`POST /v1/convai/triage-tickets/{agentqa_ticket_id}/merge`

Merge Agent Conversation Tickets

**Parameters:**

- `agentqa_ticket_id` (required)
- `source_ticket_ids` (required)

### `elevenlabs.agents.triage_tickets.add_turn_comment`

`POST /v1/convai/triage-tickets/{agentqa_ticket_id}/turn-comments`

Add Turn Comment To Agent Conversation Ticket

**Parameters:**

- `agentqa_ticket_id` (required)
- `turn_index` (required)
- `comment` (required)

## Agents PhoneNumbers

### `elevenlabs.agents.phone_numbers.list`

`GET /v1/convai/phone-numbers`

List Phone Numbers

**Parameters:**

- `provider`
- `agent_id`
- `branch_id`

### `elevenlabs.agents.phone_numbers.create`

`POST /v1/convai/phone-numbers`

Import Phone Number

### `elevenlabs.agents.phone_numbers.get`

`GET /v1/convai/phone-numbers/{phone_number_id}`

Get Phone Number

**Parameters:**

- `phone_number_id` (required)

### `elevenlabs.agents.phone_numbers.update`

`PATCH /v1/convai/phone-numbers/{phone_number_id}`

Update Phone Number

**Parameters:**

- `phone_number_id` (required)
- `agent_id`
- `label`
- `inbound_trunk_config`
- `outbound_trunk_config`
- `livekit_stack`
- `store_sip_messages`
- `environment`
- `branch_id`

### `elevenlabs.agents.phone_numbers.delete`

`DELETE /v1/convai/phone-numbers/{phone_number_id}`

Delete Phone Number

**Parameters:**

- `phone_number_id` (required)

### `elevenlabs.agents.phone_numbers.list_v2`

`GET /v1/convai/v2/phone-numbers`

List Phone Numbers Page

**Parameters:**

- `page_size`
- `search`
- `label`
- `phone_number`
- `provider`
- `supports_outbound`
- `agent_id`
- `branch_id`
- `sort_by`
- `sort_direction`
- `cursor`

### `elevenlabs.agents.phone_numbers.get_sip_messages`

`GET /v1/convai/phone-numbers/{phone_number_id}/sip-messages`

Get Sip Messages For A Phone Number

**Parameters:**

- `phone_number_id` (required)
- `page_size`
- `cursor`

## Agents Llm

### `elevenlabs.agents.llm.list`

`GET /v1/convai/llm/list`

List Available Llms

## Agents Analytics LiveCount

### `elevenlabs.agents.analytics.live_count.get`

`GET /v1/convai/analytics/live-count`

Get Live Count

**Parameters:**

- `agent_id`
- `agent_ids`

## Agents KnowledgeBase Documents

### `elevenlabs.agents.knowledge_base.documents.create_from_url`

`POST /v1/convai/knowledge-base/url`

Create Url Document

**Parameters:**

- `url` (required)
- `name`
- `parent_folder_id`
- `enable_auto_sync`
- `auto_remove`
- `minimum_frequency_days`

### `elevenlabs.agents.knowledge_base.documents.create_from_file`

`POST /v1/convai/knowledge-base/file`

Create File Document

**Parameters:**

- `file` (required)
- `name`
- `parent_folder_id`

### `elevenlabs.agents.knowledge_base.documents.create_from_text`

`POST /v1/convai/knowledge-base/text`

Create Text Document

**Parameters:**

- `text` (required)
- `name`
- `parent_folder_id`

### `elevenlabs.agents.knowledge_base.documents.create_folder`

`POST /v1/convai/knowledge-base/folder`

Create Folder

**Parameters:**

- `name` (required)
- `parent_folder_id`
- `enable_auto_sync`
- `auto_remove`
- `minimum_frequency_days`

### `elevenlabs.agents.knowledge_base.documents.get`

`GET /v1/convai/knowledge-base/{documentation_id}`

Get Documentation From Knowledge Base

**Parameters:**

- `documentation_id` (required)
- `agent_id`

### `elevenlabs.agents.knowledge_base.documents.update`

`PATCH /v1/convai/knowledge-base/{documentation_id}`

Update Document

**Parameters:**

- `documentation_id` (required)
- `name`
- `content`
- `enable_auto_sync`
- `auto_remove`
- `minimum_frequency_days`
- `tighten_only`

### `elevenlabs.agents.knowledge_base.documents.delete`

`DELETE /v1/convai/knowledge-base/{documentation_id}`

Delete Knowledge Base Document Or Folder

**Parameters:**

- `documentation_id` (required)
- `force`

### `elevenlabs.agents.knowledge_base.documents.get_agents`

`GET /v1/convai/knowledge-base/{documentation_id}/dependent-agents`

Get Dependent Agents List

**Parameters:**

- `documentation_id` (required)
- `dependent_type`
- `page_size`
- `cursor`

### `elevenlabs.agents.knowledge_base.documents.get_bulk_agents`

`POST /v1/convai/knowledge-base/dependent-agents`

Get Dependent Agents For Multiple Documents

**Parameters:**

- `dependent_type`
- `page_size`
- `cursor`
- `document_ids` (required)

### `elevenlabs.agents.knowledge_base.documents.get_content`

`GET /v1/convai/knowledge-base/{documentation_id}/content`

Get Document Content

**Parameters:**

- `documentation_id` (required)

### `elevenlabs.agents.knowledge_base.documents.get_source_file_url`

`GET /v1/convai/knowledge-base/{documentation_id}/source-file-url`

Get Document Source File Url

**Parameters:**

- `documentation_id` (required)

### `elevenlabs.agents.knowledge_base.documents.move`

`POST /v1/convai/knowledge-base/{document_id}/move`

Move Entity To Folder

**Parameters:**

- `document_id` (required)
- `move_to`

### `elevenlabs.agents.knowledge_base.documents.bulk_move`

`POST /v1/convai/knowledge-base/bulk-move`

Bulk Move Entities To Folder

**Parameters:**

- `document_ids` (required)
- `move_to`

### `elevenlabs.agents.knowledge_base.documents.bulk_delete`

`POST /v1/convai/knowledge-base/bulk-delete`

Bulk Delete Knowledge Base Documents

**Parameters:**

- `document_ids` (required)
- `force`

## Agents KnowledgeBase CrawlJobs

### `elevenlabs.agents.knowledge_base.crawl_jobs.list`

`GET /v1/convai/knowledge-base/crawl`

List Ongoing And Recent Crawl Jobs Created By A User

**Parameters:**

- `include_job_ids`
- `page_size`
- `cursor`

### `elevenlabs.agents.knowledge_base.crawl_jobs.create`

`POST /v1/convai/knowledge-base/crawl`

Create Crawl Job

**Parameters:**

- `url` (required)
- `max_depth`
- `max_pages`
- `pattern`
- `exclude_patterns`
- `sitemap_urls`
- `parent_folder_id`
- `enable_auto_sync`
- `auto_remove`
- `auto_discover`
- `minimum_frequency_days`

### `elevenlabs.agents.knowledge_base.crawl_jobs.get`

`GET /v1/convai/knowledge-base/crawl/{crawl_job_id}`

Get Crawl Job Details

**Parameters:**

- `crawl_job_id` (required)

### `elevenlabs.agents.knowledge_base.crawl_jobs.cancel`

`POST /v1/convai/knowledge-base/crawl/{crawl_job_id}/cancel`

Cancel Crawl Job

**Parameters:**

- `crawl_job_id` (required)

## Agents KnowledgeBase Document

### `elevenlabs.agents.knowledge_base.document.update_file`

`PATCH /v1/convai/knowledge-base/{documentation_id}/update-file`

Update File Document

**Parameters:**

- `documentation_id` (required)
- `file` (required)

### `elevenlabs.agents.knowledge_base.document.refresh`

`POST /v1/convai/knowledge-base/{documentation_id}/refresh`

Refresh Url Document Content

**Parameters:**

- `documentation_id` (required)

### `elevenlabs.agents.knowledge_base.document.compute_rag_index`

`POST /v1/convai/knowledge-base/{documentation_id}/rag-index`

Compute Rag Index.

**Parameters:**

- `documentation_id` (required)
- `model` (required)

## Agents KnowledgeBase Documents Chunk

### `elevenlabs.agents.knowledge_base.documents.chunk.get`

`GET /v1/convai/knowledge-base/{documentation_id}/chunk/{chunk_id}`

Get Documentation Chunk From Knowledge Base

**Parameters:**

- `documentation_id` (required)
- `chunk_id` (required)
- `embedding_model`

## Agents KnowledgeBase Documents Chunks

### `elevenlabs.agents.knowledge_base.documents.chunks.list`

`GET /v1/convai/knowledge-base/{documentation_id}/chunks`

Get All Rag Chunks For A Document

**Parameters:**

- `documentation_id` (required)
- `embedding_model` (required)
- `page_size`
- `cursor`

## Agents Conversations Topics

### `elevenlabs.agents.conversations.topics.get`

`GET /v1/convai/agents/{agent_id}/topics`

Get Agent Conversation Topics

**Parameters:**

- `agent_id` (required)
- `page_size`
- `sort_by`
- `sort_direction`
- `from_unix_secs`
- `to_unix_secs`
- `include_evaluation_criteria`
- `cursor`

## Agents Tools

### `elevenlabs.agents.tools.list`

`GET /v1/convai/tools`

Get Tools

**Parameters:**

- `search`
- `page_size`
- `show_only_owned_documents`
- `created_by_user_id`
- `types`
- `sort_direction`
- `sort_by`
- `used_by_agent_id`
- `cursor`

### `elevenlabs.agents.tools.create`

`POST /v1/convai/tools`

Add Tool

**Parameters:**

- `tool_config` (required)
- `response_mocks`

### `elevenlabs.agents.tools.get`

`GET /v1/convai/tools/{tool_id}`

Get Tool

**Parameters:**

- `tool_id` (required)
- `environment`

### `elevenlabs.agents.tools.update`

`PATCH /v1/convai/tools/{tool_id}`

Update Tool

**Parameters:**

- `tool_id` (required)
- `tool_config` (required)
- `response_mocks`

### `elevenlabs.agents.tools.delete`

`DELETE /v1/convai/tools/{tool_id}`

Delete Tool

**Parameters:**

- `tool_id` (required)
- `force`

### `elevenlabs.agents.tools.get_dependent_agents`

`GET /v1/convai/tools/{tool_id}/dependent-agents`

Get Dependent Agents List

**Parameters:**

- `tool_id` (required)
- `cursor`
- `page_size`

### `elevenlabs.agents.tools.list`

`GET /v1/convai/mcp-servers/{mcp_server_id}/tools`

List Mcp Server Tools

**Parameters:**

- `mcp_server_id` (required)
- `environment`

## Agents Tools Executions

### `elevenlabs.agents.tools.executions.get`

`GET /v1/convai/tools/{tool_id}/executions`

Get Tool Executions

**Parameters:**

- `tool_id` (required)
- `cursor`
- `page_size`
- `is_error`
- `agent_id`
- `branch_id`
- `start_time`
- `end_time`

## Agents AnalysisItems

### `elevenlabs.agents.analysis_items.list`

`GET /v1/convai/analysis-items`

List Analysis Items

**Parameters:**

- `search`
- `page_size`
- `kind`
- `analysis_item_ids`
- `created_by_user_id`
- `sort_direction`
- `cursor`

### `elevenlabs.agents.analysis_items.create`

`POST /v1/convai/analysis-items`

Create Analysis Item

### `elevenlabs.agents.analysis_items.update_attachments`

`PATCH /v1/convai/analysis-items/{analysis_item_id}/attachments`

Update Analysis Item Attachments

**Parameters:**

- `analysis_item_id` (required)
- `source` (required)
- `attach`
- `detach`

### `elevenlabs.agents.analysis_items.get`

`GET /v1/convai/analysis-items/{analysis_item_id}`

Get Analysis Item

**Parameters:**

- `analysis_item_id` (required)

### `elevenlabs.agents.analysis_items.update`

`PATCH /v1/convai/analysis-items/{analysis_item_id}`

Update Analysis Item

**Parameters:**

- `analysis_item_id` (required)

### `elevenlabs.agents.analysis_items.delete`

`DELETE /v1/convai/analysis-items/{analysis_item_id}`

Delete Analysis Item

**Parameters:**

- `analysis_item_id` (required)
- `force`

### `elevenlabs.agents.analysis_items.list_versions`

`GET /v1/convai/analysis-items/{analysis_item_id}/versions`

List Analysis Item Versions

**Parameters:**

- `analysis_item_id` (required)
- `page_size`
- `cursor`

### `elevenlabs.agents.analysis_items.copy`

`POST /v1/convai/analysis-items/{analysis_item_id}/copy`

Copy Analysis Item

**Parameters:**

- `analysis_item_id` (required)

## Agents AnalysisItems DependentAgents

### `elevenlabs.agents.analysis_items.dependent_agents.get`

`GET /v1/convai/analysis-items/{analysis_item_id}/dependent-agents`

Get Analysis Item Dependent Agents

**Parameters:**

- `analysis_item_id` (required)
- `page_size`
- `cursor`

## Agents Secrets

### `elevenlabs.agents.secrets.list`

`GET /v1/convai/secrets`

Get Convai Workspace Secrets

**Parameters:**

- `page_size`
- `dependency_limit`
- `search`
- `cursor`

### `elevenlabs.agents.secrets.create`

`POST /v1/convai/secrets`

Create Convai Workspace Secret

**Parameters:**

- `type` (required)
- `name` (required)
- `value` (required)

### `elevenlabs.agents.secrets.get`

`GET /v1/convai/secrets/{secret_id}`

Get Convai Workspace Secret

**Parameters:**

- `secret_id` (required)

### `elevenlabs.agents.secrets.update`

`PATCH /v1/convai/secrets/{secret_id}`

Update Convai Workspace Secret

**Parameters:**

- `secret_id` (required)
- `type` (required)
- `name` (required)
- `value` (required)

### `elevenlabs.agents.secrets.delete`

`DELETE /v1/convai/secrets/{secret_id}`

Delete Convai Workspace Secret

**Parameters:**

- `secret_id` (required)

### `elevenlabs.agents.secrets.get_dependencies`

`GET /v1/convai/secrets/{secret_id}/dependencies/{resource_type}`

Get Secret Dependencies By Type

**Parameters:**

- `secret_id` (required)
- `resource_type` (required)
- `page_size`
- `cursor`

## Agents BatchCalls

### `elevenlabs.agents.batch_calls.create`

`POST /v1/convai/batch-calling/submit`

Submit A Batch Call Request.

**Parameters:**

- `call_name` (required)
- `agent_id` (required)
- `recipients` (required)
- `scheduled_time_unix`
- `agent_phone_number_id`
- `whatsapp_params`
- `timezone`
- `branch_id`
- `environment`
- `telephony_call_config`
- `target_concurrency_limit`

### `elevenlabs.agents.batch_calls.list`

`GET /v1/convai/batch-calling/workspace`

Get All Batch Calls For A Workspace.

**Parameters:**

- `limit`
- `last_doc`
- `agent_id`

### `elevenlabs.agents.batch_calls.get`

`GET /v1/convai/batch-calling/{batch_id}`

Get A Batch Call By Id.

**Parameters:**

- `batch_id` (required)

### `elevenlabs.agents.batch_calls.delete`

`DELETE /v1/convai/batch-calling/{batch_id}`

Delete A Batch Call.

**Parameters:**

- `batch_id` (required)

### `elevenlabs.agents.batch_calls.cancel`

`POST /v1/convai/batch-calling/{batch_id}/cancel`

Cancel A Batch Call.

**Parameters:**

- `batch_id` (required)

### `elevenlabs.agents.batch_calls.retry_`

`POST /v1/convai/batch-calling/{batch_id}/retry`

Retry A Batch Call.

**Parameters:**

- `batch_id` (required)

### `elevenlabs.agents.batch_calls.export`

`GET /v1/convai/batch-calling/{batch_id}/export`

Export Batch Call Results

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `batch_id` (required)
- `limit`

## Agents SipTrunk

### `elevenlabs.agents.sip_trunk.outbound_call`

`POST /v1/convai/sip-trunk/outbound-call`

Handle An Outbound Call Via Sip Trunk

**Parameters:**

- `agent_id` (required)
- `agent_phone_number_id` (required)
- `to_number` (required)
- `conversation_initiation_client_data`
- `telephony_call_config`

## Agents McpServers

### `elevenlabs.agents.mcp_servers.list`

`GET /v1/convai/mcp-servers`

List Mcp Servers

### `elevenlabs.agents.mcp_servers.create`

`POST /v1/convai/mcp-servers`

Create Mcp Server

**Parameters:**

- `config` (required)

### `elevenlabs.agents.mcp_servers.get`

`GET /v1/convai/mcp-servers/{mcp_server_id}`

Get Mcp Server

**Parameters:**

- `mcp_server_id` (required)

### `elevenlabs.agents.mcp_servers.update`

`PATCH /v1/convai/mcp-servers/{mcp_server_id}`

Update Mcp Server Configuration

**Parameters:**

- `mcp_server_id` (required)
- `approval_policy`
- `force_pre_tool_speech`
- `pre_tool_speech`
- `disable_interruptions`
- `interruption_mode`
- `tool_call_sound`
- `tool_call_sound_behavior`
- `execution_mode`
- `response_timeout_secs`
- `request_headers`
- `request_meta`
- `disable_compression`
- `secret_token`
- `auth_connection`

### `elevenlabs.agents.mcp_servers.delete`

`DELETE /v1/convai/mcp-servers/{mcp_server_id}`

Delete Mcp Server

**Parameters:**

- `mcp_server_id` (required)

## Agents McpServers ToolApprovals

### `elevenlabs.agents.mcp_servers.tool_approvals.create`

`POST /v1/convai/mcp-servers/{mcp_server_id}/tool-approvals`

Create Mcp Server Tool Approval

**Parameters:**

- `mcp_server_id` (required)
- `tool_name` (required)
- `tool_description` (required)
- `input_schema`
- `approval_policy`

### `elevenlabs.agents.mcp_servers.tool_approvals.delete`

`DELETE /v1/convai/mcp-servers/{mcp_server_id}/tool-approvals/{tool_name}`

Delete Mcp Server Tool Approval

**Parameters:**

- `mcp_server_id` (required)
- `tool_name` (required)

## Agents McpServers ToolConfigs

### `elevenlabs.agents.mcp_servers.tool_configs.create`

`POST /v1/convai/mcp-servers/{mcp_server_id}/tool-configs`

Create Mcp Tool Configuration Override

**Parameters:**

- `mcp_server_id` (required)
- `environment`
- `force_pre_tool_speech`
- `pre_tool_speech`
- `disable_interruptions`
- `interruption_mode`
- `tool_call_sound`
- `tool_call_sound_behavior`
- `execution_mode`
- `response_timeout_secs`
- `assignments`
- `input_overrides`
- `response_mocks`
- `tool_name` (required)

### `elevenlabs.agents.mcp_servers.tool_configs.get`

`GET /v1/convai/mcp-servers/{mcp_server_id}/tool-configs/{tool_name}`

Get Mcp Tool Configuration Override

**Parameters:**

- `mcp_server_id` (required)
- `tool_name` (required)

### `elevenlabs.agents.mcp_servers.tool_configs.update`

`PATCH /v1/convai/mcp-servers/{mcp_server_id}/tool-configs/{tool_name}`

Update Mcp Tool Configuration Override

**Parameters:**

- `mcp_server_id` (required)
- `tool_name` (required)
- `environment`
- `force_pre_tool_speech`
- `pre_tool_speech`
- `disable_interruptions`
- `interruption_mode`
- `tool_call_sound`
- `tool_call_sound_behavior`
- `execution_mode`
- `response_timeout_secs`
- `assignments`
- `input_overrides`
- `response_mocks`

### `elevenlabs.agents.mcp_servers.tool_configs.delete`

`DELETE /v1/convai/mcp-servers/{mcp_server_id}/tool-configs/{tool_name}`

Delete Mcp Tool Configuration Override

**Parameters:**

- `mcp_server_id` (required)
- `tool_name` (required)

## Agents WhatsappAccounts

### `elevenlabs.agents.whatsapp_accounts.get`

`GET /v1/convai/whatsapp-accounts/{phone_number_id}`

Get Whatsapp Account

**Parameters:**

- `phone_number_id` (required)

### `elevenlabs.agents.whatsapp_accounts.update`

`PATCH /v1/convai/whatsapp-accounts/{phone_number_id}`

Update Whatsapp Account

**Parameters:**

- `phone_number_id` (required)
- `assigned_agent_id`
- `enable_messaging`
- `enable_audio_message_response`
- `enable_typing_indicator`

### `elevenlabs.agents.whatsapp_accounts.delete`

`DELETE /v1/convai/whatsapp-accounts/{phone_number_id}`

Delete Whatsapp Account

**Parameters:**

- `phone_number_id` (required)

### `elevenlabs.agents.whatsapp_accounts.list`

`GET /v1/convai/whatsapp-accounts`

List Whatsapp Accounts

**Parameters:**

- `agent_id`

## Agents Branches

### `elevenlabs.agents.branches.list`

`GET /v1/convai/agents/{agent_id}/branches`

List Agent Branches

**Parameters:**

- `agent_id` (required)
- `include_archived`
- `limit`
- `include_commit_status`

### `elevenlabs.agents.branches.create`

`POST /v1/convai/agents/{agent_id}/branches`

Create A New Branch

**Parameters:**

- `agent_id` (required)
- `parent_version_id` (required)
- `name` (required)
- `description` (required)
- `conversation_config`
- `platform_settings`
- `workflow`
- `include_draft`

### `elevenlabs.agents.branches.get`

`GET /v1/convai/agents/{agent_id}/branches/{branch_id}`

Get Agent Branch

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)

### `elevenlabs.agents.branches.update`

`PATCH /v1/convai/agents/{agent_id}/branches/{branch_id}`

Update Agent Branch

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `name`
- `description`
- `is_archived`
- `protection_status`
- `auto_rebase`

### `elevenlabs.agents.branches.preview_merge`

`GET /v1/convai/agents/{agent_id}/branches/{source_branch_id}/merge-preview`

Preview Merged Configuration

**Parameters:**

- `agent_id` (required)
- `source_branch_id` (required)
- `target_branch_id` (required)
- `force`
- `include_procedure_generated_workflow_elements`

### `elevenlabs.agents.branches.merge`

`POST /v1/convai/agents/{agent_id}/branches/{source_branch_id}/merge`

Merge A Branch Into A Target Branch

**Parameters:**

- `agent_id` (required)
- `source_branch_id` (required)
- `target_branch_id` (required)
- `archive_source_branch`
- `force`

### `elevenlabs.agents.branches.preview_rebase`

`GET /v1/convai/agents/{agent_id}/branches/{branch_id}/rebase-preview`

Preview Rebased Configuration

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `source_branch_id`
- `include_procedure_generated_workflow_elements`

### `elevenlabs.agents.branches.rebase`

`POST /v1/convai/agents/{agent_id}/branches/{branch_id}/rebase`

Rebase A Branch Onto Main

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `source_branch_id`

## Agents Versions

### `elevenlabs.agents.versions.get`

`GET /v1/convai/agents/{agent_id}/versions/{version_id}`

Get Agent Version Metadata

**Parameters:**

- `agent_id` (required)
- `version_id` (required)

## Agents Deployments

### `elevenlabs.agents.deployments.list`

`GET /v1/convai/agents/{agent_id}/deployments`

List Agent Deployments

**Parameters:**

- `agent_id` (required)
- `page`
- `page_size`

### `elevenlabs.agents.deployments.create`

`POST /v1/convai/agents/{agent_id}/deployments`

Create Or Update Deployments

**Parameters:**

- `agent_id` (required)
- `deployment_request` (required)

## Agents Drafts

### `elevenlabs.agents.drafts.create`

`POST /v1/convai/agents/{agent_id}/drafts`

Create Agent Draft

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `conversation_config` (required)
- `platform_settings` (required)
- `workflow` (required)
- `name` (required)
- `tags`

### `elevenlabs.agents.drafts.delete`

`DELETE /v1/convai/agents/{agent_id}/drafts`

Delete Agent Draft

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)

### `elevenlabs.agents.drafts.get`

`GET /v1/convai/agents/{agent_id}/branches/{branch_id}/procedures/{procedure_id}/draft`

Get Procedure Draft

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `procedure_id` (required)

### `elevenlabs.agents.drafts.update`

`PATCH /v1/convai/agents/{agent_id}/branches/{branch_id}/procedures/{procedure_id}/draft`

Update Procedure Draft

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `procedure_id` (required)
- `name` (required)
- `content` (required)
- `type` (required)
- `trigger`

### `elevenlabs.agents.drafts.delete`

`DELETE /v1/convai/agents/{agent_id}/branches/{branch_id}/procedures/{procedure_id}/draft`

Delete Procedure Draft

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `procedure_id` (required)

## Agents MergeProposals

### `elevenlabs.agents.merge_proposals.list`

`GET /v1/convai/agents/{agent_id}/merge-proposals`

List Proposals

**Parameters:**

- `agent_id` (required)
- `status`
- `source_branch_id`
- `target_branch_id`
- `search`
- `page_size`
- `cursor`

### `elevenlabs.agents.merge_proposals.create`

`POST /v1/convai/agents/{agent_id}/merge-proposals`

Create A Merge Proposal

**Parameters:**

- `agent_id` (required)
- `source_branch_id` (required)
- `target_branch_id` (required)
- `title` (required)
- `description`
- `requested_reviewer_user_ids`
- `triage_ticket_id`

### `elevenlabs.agents.merge_proposals.get`

`GET /v1/convai/agents/{agent_id}/merge-proposals/{merge_proposal_id}`

Get A Merge Proposal

**Parameters:**

- `agent_id` (required)
- `merge_proposal_id` (required)

### `elevenlabs.agents.merge_proposals.update`

`PATCH /v1/convai/agents/{agent_id}/merge-proposals/{merge_proposal_id}`

Update A Merge Proposal

**Parameters:**

- `agent_id` (required)
- `merge_proposal_id` (required)
- `title`
- `description`
- `requested_reviewer_user_ids`
- `close`

### `elevenlabs.agents.merge_proposals.submit_review`

`POST /v1/convai/agents/{agent_id}/merge-proposals/{merge_proposal_id}/reviews`

Review A Merge Proposal

**Parameters:**

- `agent_id` (required)
- `merge_proposal_id` (required)
- `state` (required)
- `comment`

### `elevenlabs.agents.merge_proposals.add_comment`

`POST /v1/convai/agents/{agent_id}/merge-proposals/{merge_proposal_id}/comments`

Comment On A Merge Proposal

**Parameters:**

- `agent_id` (required)
- `merge_proposal_id` (required)
- `body` (required)

### `elevenlabs.agents.merge_proposals.merge`

`POST /v1/convai/agents/{agent_id}/merge-proposals/{merge_proposal_id}/merge`

Merge A Merge Proposal

**Parameters:**

- `agent_id` (required)
- `merge_proposal_id` (required)
- `archive_source_branch`
- `force`

## Agents OutboundCampaigns Config

### `elevenlabs.agents.outbound_campaigns.config.get`

`GET /v1/convai/outbound-campaigns/config`

Get Outbound Campaign Configuration

### `elevenlabs.agents.outbound_campaigns.config.update`

`PUT /v1/convai/outbound-campaigns/config`

Replace Outbound Campaign Configuration

**Parameters:**

- `expected_version`
- `config` (required)

## Agents OutboundCampaigns

### `elevenlabs.agents.outbound_campaigns.list`

`GET /v1/convai/outbound-campaigns/campaigns`

List Outbound Campaigns

**Parameters:**

- `page_size`
- `status`
- `agent_id`
- `channel`
- `mode`
- `search`
- `cursor`

### `elevenlabs.agents.outbound_campaigns.pause_all`

`POST /v1/convai/outbound-campaigns/campaigns/pause-all`

Pause All Outbound Campaigns

### `elevenlabs.agents.outbound_campaigns.stop_all`

`POST /v1/convai/outbound-campaigns/campaigns/stop-all`

Stop All Outbound Campaigns

### `elevenlabs.agents.outbound_campaigns.create`

`POST /v1/convai/outbound-campaigns/campaigns/submit`

Create An Outbound Campaign

**Parameters:**

- `call_name` (required)
- `agent_id` (required)
- `recipients` (required)
- `scheduled_time_unix`
- `timezone`
- `branch_id`
- `environment`
- `target_concurrency_limit`
- `idempotency_key`
- `policy`
- `variant`
- `channel_config` (required)

### `elevenlabs.agents.outbound_campaigns.get`

`GET /v1/convai/outbound-campaigns/campaigns/{campaign_id}`

Get An Outbound Campaign

**Parameters:**

- `campaign_id` (required)

### `elevenlabs.agents.outbound_campaigns.get_progress`

`GET /v1/convai/outbound-campaigns/campaigns/{campaign_id}/progress`

Get Outbound Campaign Progress

**Parameters:**

- `campaign_id` (required)

### `elevenlabs.agents.outbound_campaigns.get_follow_up_requests`

`GET /v1/convai/outbound-campaigns/campaigns/{campaign_id}/follow-up-requests`

Get Outbound Campaign Follow-Up Requests

**Parameters:**

- `campaign_id` (required)

### `elevenlabs.agents.outbound_campaigns.pause`

`POST /v1/convai/outbound-campaigns/campaigns/{campaign_id}/pause`

Pause An Outbound Campaign

**Parameters:**

- `campaign_id` (required)

### `elevenlabs.agents.outbound_campaigns.resume`

`POST /v1/convai/outbound-campaigns/campaigns/{campaign_id}/resume`

Resume An Outbound Campaign

**Parameters:**

- `campaign_id` (required)

### `elevenlabs.agents.outbound_campaigns.stop`

`POST /v1/convai/outbound-campaigns/campaigns/{campaign_id}/stop`

Stop An Outbound Campaign

**Parameters:**

- `campaign_id` (required)

## Agents OutboundCampaigns Leads

### `elevenlabs.agents.outbound_campaigns.leads.list`

`GET /v1/convai/outbound-campaigns/campaigns/{campaign_id}/leads`

List Outbound Campaign Leads

**Parameters:**

- `campaign_id` (required)
- `page_size`
- `search`
- `status`
- `disposition`
- `cursor`

### `elevenlabs.agents.outbound_campaigns.leads.get`

`GET /v1/convai/outbound-campaigns/campaigns/{campaign_id}/leads/{lead_id}`

Get An Outbound Campaign Lead

**Parameters:**

- `campaign_id` (required)
- `lead_id` (required)

### `elevenlabs.agents.outbound_campaigns.leads.delete`

`DELETE /v1/convai/outbound-campaigns/campaigns/{campaign_id}/leads/{lead_id}`

Remove An Outbound Campaign Lead

**Parameters:**

- `campaign_id` (required)
- `lead_id` (required)

## Agents OutboundCampaigns Calls

### `elevenlabs.agents.outbound_campaigns.calls.list`

`GET /v1/convai/outbound-campaigns/campaigns/{campaign_id}/calls`

List Outbound Campaign Calls

**Parameters:**

- `campaign_id` (required)
- `page_size`
- `lead_id`
- `status`
- `call_result`
- `stage`
- `cursor`

### `elevenlabs.agents.outbound_campaigns.calls.export`

`GET /v1/convai/outbound-campaigns/campaigns/{campaign_id}/export`

Export Outbound Campaign Calls

Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent on the first iteration and each chunk is yielded as it arrives, so playback or a file write can start before the server has finished. `read` on the Enumerator returns the whole body as one binary String. A non-2xx response raises its typed error from the first iteration or `read`, not from this call.

**Parameters:**

- `campaign_id` (required)
- `limit`

## Agents OutboundCampaigns Attention

### `elevenlabs.agents.outbound_campaigns.attention.list`

`GET /v1/convai/outbound-campaigns/attention`

List Outbound Campaign Attention Items

**Parameters:**

- `campaign_id`
- `include_resolved`
- `page_size`
- `cursor`

### `elevenlabs.agents.outbound_campaigns.attention.retry_`

`POST /v1/convai/outbound-campaigns/attention/{attention_id}/retry`

Retry An Outbound Campaign Attention Item

**Parameters:**

- `attention_id` (required)

### `elevenlabs.agents.outbound_campaigns.attention.resolve`

`POST /v1/convai/outbound-campaigns/attention/{attention_id}/resolve`

Resolve An Outbound Campaign Attention Item

**Parameters:**

- `attention_id` (required)
- `resolution` (required)

## SpeechEngine

### `elevenlabs.speech_engine.list`

`GET /v1/speech-engine`

List Speech Engines

**Parameters:**

- `page_size`
- `search`
- `sort_direction`
- `sort_by`
- `cursor`

### `elevenlabs.speech_engine.create`

`POST /v1/speech-engine`

Create Speech Engine

**Parameters:**

- `name`
- `speech_engine` (required)
- `asr`
- `tts`
- `turn`
- `vad`
- `conversation`
- `privacy`
- `call_limits`
- `auth`
- `language`
- `cascade_timeout_seconds`
- `tags`
- `overrides`

### `elevenlabs.speech_engine.get`

`GET /v1/speech-engine/{speech_engine_id}`

Get Speech Engine

**Parameters:**

- `speech_engine_id` (required)

### `elevenlabs.speech_engine.update`

`PATCH /v1/speech-engine/{speech_engine_id}`

Update Speech Engine

**Parameters:**

- `speech_engine_id` (required)
- `name`
- `speech_engine`
- `asr`
- `tts`
- `turn`
- `vad`
- `conversation`
- `privacy`
- `call_limits`
- `auth`
- `language`
- `cascade_timeout_seconds`
- `tags`
- `overrides`

### `elevenlabs.speech_engine.delete`

`DELETE /v1/speech-engine/{speech_engine_id}`

Delete Speech Engine

**Parameters:**

- `speech_engine_id` (required)

### `elevenlabs.speech_engine.duplicate`

`POST /v1/speech-engine/{speech_engine_id}/duplicate`

Duplicate Speech Engine

**Parameters:**

- `speech_engine_id` (required)
- `name`

## Agents Procedures

### `elevenlabs.agents.procedures.list`

`GET /v1/convai/agents/{agent_id}/branches/{branch_id}/procedures`

List Procedures

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `agent_version_id`

### `elevenlabs.agents.procedures.create`

`POST /v1/convai/agents/{agent_id}/branches/{branch_id}/procedures`

Create Procedure

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `name`
- `content`
- `type`
- `trigger`
- `folder_parent_id`

### `elevenlabs.agents.procedures.compile`

`POST /v1/convai/agents/{agent_id}/branches/{branch_id}/procedures/compile`

Legacy: Compile Procedures

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)

### `elevenlabs.agents.procedures.get`

`GET /v1/convai/agents/{agent_id}/branches/{branch_id}/procedures/{procedure_id}`

Get Procedure

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `procedure_id` (required)
- `version_id`
- `agent_version_id`

### `elevenlabs.agents.procedures.remove`

`DELETE /v1/convai/agents/{agent_id}/branches/{branch_id}/procedures/{procedure_id}`

Remove Procedure

**Parameters:**

- `agent_id` (required)
- `branch_id` (required)
- `procedure_id` (required)

## Agents Conversations Analysis

### `elevenlabs.agents.conversations.analysis.run`

`POST /v1/convai/conversations/{conversation_id}/analysis/run`

Run Conversation Analysis

**Parameters:**

- `conversation_id` (required)

### `elevenlabs.agents.conversations.analysis.run_evaluation`

`POST /v1/convai/conversations/{conversation_id}/analysis/evaluations/run`

Run Conversation Evaluation

**Parameters:**

- `conversation_id` (required)
- `evaluation_id` (required)
- `scope`
- `evaluated_agent_id`
- `evaluated_branch_id`

## EnvironmentVariables

### `elevenlabs.environment_variables.list`

`GET /v1/convai/environment-variables`

List Environment Variables

**Parameters:**

- `cursor`
- `page_size`
- `label`
- `environment`
- `type`

### `elevenlabs.environment_variables.create`

`POST /v1/convai/environment-variables`

Create Environment Variable

### `elevenlabs.environment_variables.get`

`GET /v1/convai/environment-variables/{env_var_id}`

Get Environment Variable

**Parameters:**

- `env_var_id` (required)

### `elevenlabs.environment_variables.update`

`PATCH /v1/convai/environment-variables/{env_var_id}`

Update Environment Variable

**Parameters:**

- `env_var_id` (required)
- `values` (required)

### `elevenlabs.environment_variables.delete`

`DELETE /v1/convai/environment-variables/{env_var_id}`

Delete Environment Variable

**Parameters:**

- `env_var_id` (required)

## Environments

### `elevenlabs.environments.list`

`GET /v1/convai/environments`

List Environments

### `elevenlabs.environments.create`

`POST /v1/convai/environments`

Create Environment

**Parameters:**

- `name` (required)

### `elevenlabs.environments.delete`

`DELETE /v1/convai/environments/{environment}`

Delete Environment

**Parameters:**

- `environment` (required)

## Agents Realtime

### `elevenlabs.agents.realtime.list_conversation_groups`

`GET /v1/convai/realtime/conversation-groups`

List Realtime Conversation Groups

**Parameters:**

- `page_size`
- `search`
- `cursor`

### `elevenlabs.agents.realtime.create_conversation_group`

`POST /v1/convai/realtime/conversation-groups`

Create Realtime Conversation Group

**Parameters:**

- `title` (required)
- `description`

### `elevenlabs.agents.realtime.get_conversation_group`

`GET /v1/convai/realtime/conversation-groups/{conversation_group_id}`

Get Realtime Conversation Group

**Parameters:**

- `conversation_group_id` (required)

### `elevenlabs.agents.realtime.update_conversation_group`

`PATCH /v1/convai/realtime/conversation-groups/{conversation_group_id}`

Update Realtime Conversation Group

**Parameters:**

- `conversation_group_id` (required)
- `title`
- `description`

### `elevenlabs.agents.realtime.delete_conversation_group`

`DELETE /v1/convai/realtime/conversation-groups/{conversation_group_id}`

Delete Realtime Conversation Group

**Parameters:**

- `conversation_group_id` (required)

### `elevenlabs.agents.realtime.set_conversation_group`

`PUT /v1/convai/realtime/conversations/{conversation_id}/conversation-group`

Set Realtime Conversation Group

**Parameters:**

- `conversation_id` (required)
- `conversation_group_id` (required)

### `elevenlabs.agents.realtime.clear_conversation_group`

`DELETE /v1/convai/realtime/conversations/{conversation_id}/conversation-group`

Clear Realtime Conversation Group

**Parameters:**

- `conversation_id` (required)

### `elevenlabs.agents.realtime.create_client_secret`

`POST /v1/convai/realtime/client_secrets`

Create Realtime Client Secret

**Parameters:**

- `session`
- `expires_after`

## Music CompositionPlan

### `elevenlabs.music.composition_plan.create`

`POST /v1/music/plan`

Generate Composition Plan

**Parameters:**

- `enable_logging`
- `prompt` (required)
- `music_length_ms`
- `source_composition_plan`
- `model_id`

## Music Finetunes

### `elevenlabs.music.finetunes.list`

`GET /v1/music/finetunes`

Get Music Finetunes

**Parameters:**

- `cursor`
- `page_size`
- `visibility`
- `created_by`
- `sort`
- `sort_direction`

### `elevenlabs.music.finetunes.create`

`POST /v1/music/finetunes`

Create Music Finetune

**Parameters:**

- `name` (required)
- `primary_genre` (required)
- `files`
- `tags`
- `visibility`
- `model_id`

### `elevenlabs.music.finetunes.get`

`GET /v1/music/finetunes/{finetune_id}`

Get Music Finetune

**Parameters:**

- `finetune_id` (required)

### `elevenlabs.music.finetunes.update`

`PATCH /v1/music/finetunes/{finetune_id}`

Update Music Finetune

**Parameters:**

- `finetune_id` (required)
- `name`
- `tags`
- `primary_genre`
- `visibility`

### `elevenlabs.music.finetunes.delete`

`DELETE /v1/music/finetunes/{finetune_id}`

Delete Music Finetune

**Parameters:**

- `finetune_id` (required)

## Productions Orders

### `elevenlabs.productions.orders.list`

`GET /v1/productions/orders`

List Orders

**Parameters:**

- `page_size`
- `offset`
- `status`
- `start_date`
- `end_date`

### `elevenlabs.productions.orders.create`

`POST /v1/productions/orders`

Create Order

**Parameters:**

- `sandbox`

### `elevenlabs.productions.orders.get`

`GET /v1/productions/orders/{order_id}`

Get Order

**Parameters:**

- `order_id` (required)

### `elevenlabs.productions.orders.update`

`PATCH /v1/productions/orders/{order_id}`

Update Order

**Parameters:**

- `order_id` (required)
- `request` (required)

### `elevenlabs.productions.orders.submit`

`POST /v1/productions/orders/{order_id}/submit`

Submit Order

**Parameters:**

- `order_id` (required)

## Productions Orders Media

### `elevenlabs.productions.orders.media.register`

`POST /v1/productions/orders/{order_id}/media`

Register Media

**Parameters:**

- `order_id` (required)
- `declared_language` (required)
- `media`
- `media_url`
- `media_url_filename`
- `media_url_content_type`

### `elevenlabs.productions.orders.media.get`

`GET /v1/productions/orders/{order_id}/media/{media_id}`

Get Media Info

**Parameters:**

- `order_id` (required)
- `media_id` (required)

## Productions Orders Items

### `elevenlabs.productions.orders.items.upsert`

`POST /v1/productions/orders/{order_id}/items`

Upsert Order Item

**Parameters:**

- `order_id` (required)
- `request` (required)

### `elevenlabs.productions.orders.items.remove`

`DELETE /v1/productions/orders/{order_id}/items/{item_id}`

Remove Order Item

**Parameters:**

- `order_id` (required)
- `item_id` (required)

## Productions Orders Deliverables

### `elevenlabs.productions.orders.deliverables.list`

`GET /v1/productions/orders/{order_id}/deliverables`

Get Order Deliverables

**Parameters:**

- `order_id` (required)

## Productions Orders Languages

### `elevenlabs.productions.orders.languages.list`

`GET /v1/productions/orders/languages/{order_item_kind}`

Get Available Languages

**Parameters:**

- `order_item_kind` (required)

## Voices Pvc

### `elevenlabs.voices.pvc.create`

`POST /v1/voices/pvc`

Create PVC voice

**Parameters:**

- `name` (required)
- `language` (required)
- `description`
- `labels`

### `elevenlabs.voices.pvc.update`

`POST /v1/voices/pvc/{voice_id}`

Edit Pvc Voice

**Parameters:**

- `voice_id` (required)
- `name`
- `language`
- `description`
- `labels`

### `elevenlabs.voices.pvc.train`

`POST /v1/voices/pvc/{voice_id}/train`

Run Pvc Training

**Parameters:**

- `voice_id` (required)
- `model_id`

## Voices Pvc Samples Waveform

### `elevenlabs.voices.pvc.samples.waveform.get`

`GET /v1/voices/pvc/{voice_id}/samples/{sample_id}/waveform`

Retrieve Voice Sample Visual Waveform

**Parameters:**

- `voice_id` (required)
- `sample_id` (required)

## Voices Pvc Samples Speakers

### `elevenlabs.voices.pvc.samples.speakers.get`

`GET /v1/voices/pvc/{voice_id}/samples/{sample_id}/speakers`

Retrieve Speaker Separation Status

**Parameters:**

- `voice_id` (required)
- `sample_id` (required)

### `elevenlabs.voices.pvc.samples.speakers.separate`

`POST /v1/voices/pvc/{voice_id}/samples/{sample_id}/separate-speakers`

Start Speaker Separation

**Parameters:**

- `voice_id` (required)
- `sample_id` (required)

## Voices Pvc Verification Captcha

### `elevenlabs.voices.pvc.verification.captcha.get`

`GET /v1/voices/pvc/{voice_id}/captcha`

Get Pvc Voice Captcha

**Parameters:**

- `voice_id` (required)

### `elevenlabs.voices.pvc.verification.captcha.verify`

`POST /v1/voices/pvc/{voice_id}/captcha`

Verify Pvc Voice Captcha

**Parameters:**

- `voice_id` (required)
- `recording` (required)

## Voices Pvc Verification

### `elevenlabs.voices.pvc.verification.request`

`POST /v1/voices/pvc/{voice_id}/verification`

Request Manual Verification

**Parameters:**

- `voice_id` (required)
- `files` (required)
- `extra_text`

## Flows Video

### `elevenlabs.flows.video.list`

`GET /v1/flows/video`

List Video Generations

**Parameters:**

- `cursor`
- `page_size`
- `status`
- `model_id`

### `elevenlabs.flows.video.create`

`POST /v1/flows/video`

Create Video Generation

### `elevenlabs.flows.video.get`

`GET /v1/flows/video/{generation_id}`

Get Video Generation

**Parameters:**

- `generation_id` (required)

## Flows Image

### `elevenlabs.flows.image.list`

`GET /v1/flows/image`

List Image Generations

**Parameters:**

- `cursor`
- `page_size`
- `status`
- `model_id`

### `elevenlabs.flows.image.create`

`POST /v1/flows/image`

Create Image Generation

### `elevenlabs.flows.image.get`

`GET /v1/flows/image/{generation_id}`

Get Image Generation

**Parameters:**

- `generation_id` (required)

## Flows Templates Runs

### `elevenlabs.flows.templates.runs.list`

`GET /v1/flows/templates/{template_id}/runs`

List Template Runs

**Parameters:**

- `template_id` (required)
- `cursor`
- `page_size`
- `version_id`

### `elevenlabs.flows.templates.runs.create`

`POST /v1/flows/templates/{template_id}/runs`

Create Template Run

**Parameters:**

- `template_id` (required)
- `inputs` (required)
- `version_id`
- `webhook`

### `elevenlabs.flows.templates.runs.get`

`GET /v1/flows/templates/{template_id}/runs/{run_id}`

Get Template Run

**Parameters:**

- `template_id` (required)
- `run_id` (required)

## Flows Templates

### `elevenlabs.flows.templates.list`

`GET /v1/flows/templates`

List Templates

**Parameters:**

- `cursor`
- `page_size`
- `versions_per_template`
- `search`

### `elevenlabs.flows.templates.get`

`GET /v1/flows/templates/{template_id}`

Get Template

**Parameters:**

- `template_id` (required)
- `versions_per_template`

## Assets

### `elevenlabs.assets.list`

`GET /v1/assets`

List Assets

**Parameters:**

- `page_size`
- `cursor`
- `search`

### `elevenlabs.assets.create`

`POST /v1/assets`

Upload Asset

**Parameters:**

- `asset` (required)
- `name` (required)

### `elevenlabs.assets.get`

`GET /v1/assets/{asset_id}`

Get Asset

**Parameters:**

- `asset_id` (required)

### `elevenlabs.assets.delete`

`DELETE /v1/assets/{asset_id}`

Delete Asset

**Parameters:**

- `asset_id` (required)

## Workspace Usage

### `elevenlabs.workspace.usage.get_usage_by_product_over_time`

`POST /v1/workspace/analytics/query/usage-by-product-over-time`

Get Workspace Usage

**Parameters:**

- `start_time` (required)
- `end_time` (required)
- `interval_seconds`
- `group_by`
- `filters`
- `time_zone`

### `elevenlabs.workspace.usage.get_usage`

`POST /v1/workspace/analytics/usage`

Get Workspace Cost Usage

**Parameters:**

- `start_time` (required)
- `end_time` (required)
- `interval_seconds` (required)
- `group_by`
- `filters`

## Workspace Analytics Requests

### `elevenlabs.workspace.analytics.requests.get`

`POST /v1/workspace/analytics/requests`

List Api Requests

**Parameters:**

- `start_time`
- `end_time`
- `limit`
- `sort`
- `filters`
- `search`
