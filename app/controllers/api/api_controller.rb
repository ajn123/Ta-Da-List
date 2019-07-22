# frozen_string_literal: true

module Api
  # class
  class ApiController < ApplicationController
    # Protect from forgery skips the need to verify authenticity token
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    before_action :authenticate

    def authenticate
      token = request.authorization
      puts token
      @user = User.find_by(api_key: token)
      # @user = authenticate_with_http_token do |token, options|
      #  puts "YOLOR"
      #  puts token
      #  User.find_by(api_key: token)
      # end

      unless @user
        render status: :unprocessable_entity, json: {
          message: 'please sumbit an API token in the header'
        }
      end

      #     @user.api_count += 1
      #     authenticate_or_request_with_http_basic do |user, api_key|
      #       puts user
      #       puts api_key
      #       User.api_authorized(api_key)
      #     end
    end
  end
end
