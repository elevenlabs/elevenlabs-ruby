# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Voices
    class Client
      def initialize(client:)
        @client = client
      end

      # Returns metadata about a specific voice.
      def get(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['with_settings'] = params[:with_settings] if params.key?(:with_settings)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: "v1/voices/#{URI.encode_uri_component(params[:voice_id].to_s)}",
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::Voice.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Deletes a voice by its ID.
      def delete(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'DELETE',
          path: "v1/voices/#{URI.encode_uri_component(params[:voice_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DeleteVoiceResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Edit a voice created by you.
      def update(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add(name: 'name', value: params[:name]) if params.key?(:name)
        params[:files]&.each { |item| body.add_file(name: 'files', file: item) }
        body.add(name: 'remove_background_noise', value: params[:remove_background_noise]) if params.key?(:remove_background_noise)
        body.add(name: 'description', value: params[:description]) if params.key?(:description)
        body.add(name: 'labels', value: params[:labels]) if params.key?(:labels)
        body.add(name: 'moderate_metadata', value: params[:moderate_metadata]) if params.key?(:moderate_metadata)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/voices/#{URI.encode_uri_component(params[:voice_id].to_s)}/edit",
          body: body,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::EditVoiceResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Gets a list of all available voices for a user with search, filtering and pagination.
      def search(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['next_page_token'] = params[:next_page_token] if params.key?(:next_page_token)
        query_params['page_size'] = params[:page_size] if params.key?(:page_size)
        query_params['search'] = params[:search] if params.key?(:search)
        query_params['sort'] = params[:sort] if params.key?(:sort)
        query_params['sort_direction'] = params[:sort_direction] if params.key?(:sort_direction)
        query_params['voice_type'] = params[:voice_type] if params.key?(:voice_type)
        query_params['category'] = params[:category] if params.key?(:category)
        query_params['fine_tuning_state'] = params[:fine_tuning_state] if params.key?(:fine_tuning_state)
        query_params['collection_id'] = params[:collection_id] if params.key?(:collection_id)
        query_params['gender'] = params[:gender] if params.key?(:gender)
        query_params['age'] = params[:age] if params.key?(:age)
        query_params['language'] = params[:language] if params.key?(:language)
        query_params['accent'] = params[:accent] if params.key?(:accent)
        query_params['use_cases'] = params[:use_cases] if params.key?(:use_cases)
        query_params['min_notice_period_days'] = params[:min_notice_period_days] if params.key?(:min_notice_period_days)
        query_params['include_custom_rates'] = params[:include_custom_rates] if params.key?(:include_custom_rates)
        query_params['include_live_moderated'] = params[:include_live_moderated] if params.key?(:include_live_moderated)
        query_params['high_quality'] = params[:high_quality] if params.key?(:high_quality)
        query_params['include_total_count'] = params[:include_total_count] if params.key?(:include_total_count)
        query_params['voice_ids'] = params[:voice_ids] if params.key?(:voice_ids)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v2/voices',
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetVoicesV2Response.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Replicates an Instant Voice Clone or Voice Design voice to a workspace in a different data residency. The target workspace must belong to the same consolidated billing group. The user must have VOICES_WRITE in the source workspace, and be an admin on the source voice. Human users (i.e. not service accounts) must also have VOICES_WRITE in the target workspace. This endpoint is available on the central environment only.
      def replicate_to_isolated_environment(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::Voices::Types::ReplicateVoiceToIsolatedEnvironmentRequestModel.new(params.except(:voice_id))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/voices/#{URI.encode_uri_component(params[:voice_id].to_s)}/replicate-to-isolated-environment",
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReplicateVoiceToIsolatedEnvironmentResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Add a shared voice to your collection of Voices
      def share(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::Voices::Types::BodyAddSharedVoiceV1VoicesAddPublicUserIDVoiceIDPost.new(params.except(:public_user_id, :voice_id))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/voices/add/#{URI.encode_uri_component(params[:public_user_id].to_s)}/#{URI.encode_uri_component(params[:voice_id].to_s)}",
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AddVoiceResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Returns a list of shared voices similar to the provided audio sample. If neither similarity_threshold nor top_k is provided, we will apply default values.
      def find_similar_voices(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add_file(name: 'audio_file', file: params[:audio_file]) if params.key?(:audio_file)
        body.add(name: 'similarity_threshold', value: params[:similarity_threshold]) if params.key?(:similarity_threshold)
        body.add(name: 'top_k', value: params[:top_k]) if params.key?(:top_k)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/similar-voices',
          body: body,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetLibraryVoicesResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Retrieves a list of shared voices.
      def get_shared(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['page_size'] = params[:page_size] if params.key?(:page_size)
        query_params['category'] = params[:category] if params.key?(:category)
        query_params['gender'] = params[:gender] if params.key?(:gender)
        query_params['age'] = params[:age] if params.key?(:age)
        query_params['accent'] = params[:accent] if params.key?(:accent)
        query_params['language'] = params[:language] if params.key?(:language)
        query_params['locale'] = params[:locale] if params.key?(:locale)
        query_params['search'] = params[:search] if params.key?(:search)
        query_params['use_cases'] = params[:use_cases] if params.key?(:use_cases)
        query_params['descriptives'] = params[:descriptives] if params.key?(:descriptives)
        query_params['featured'] = params[:featured] if params.key?(:featured)
        query_params['min_notice_period_days'] = params[:min_notice_period_days] if params.key?(:min_notice_period_days)
        query_params['include_custom_rates'] = params[:include_custom_rates] if params.key?(:include_custom_rates)
        query_params['include_live_moderated'] = params[:include_live_moderated] if params.key?(:include_live_moderated)
        query_params['reader_app_enabled'] = params[:reader_app_enabled] if params.key?(:reader_app_enabled)
        query_params['owner_id'] = params[:owner_id] if params.key?(:owner_id)
        query_params['sort'] = params[:sort] if params.key?(:sort)
        query_params['page'] = params[:page] if params.key?(:page)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v1/shared-voices',
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetLibraryVoicesResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      def samples
        @samples ||= Samples::Client.new(client: @client)
      end

      def collections
        @collections ||= Collections::Client.new(client: @client)
      end

      def settings
        @settings ||= Settings::Client.new(client: @client)
      end

      def accents
        @accents ||= Accents::Client.new(client: @client)
      end

      def ivc
        @ivc ||= Ivc::Client.new(client: @client)
      end

      def pvc
        @pvc ||= Pvc::Client.new(client: @client)
      end
    end
  end
end
