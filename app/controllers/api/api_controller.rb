# frozen_string_literal: true

module Api
  # class
  class ApiController < ApplicationController

    # Protect from forgery skips the need to verify authenticity token
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token



    def authenticate
      
      authenticate or_request_with_http_basic do |user, api_key|
        User.api_authorized?(api_key)
      end
      
    end
  end
end
