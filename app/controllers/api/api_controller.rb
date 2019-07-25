
require 'jwt'
module Api
  # class
  class ApiController < ApplicationController
    # Protect from forgery skips the need to verify authenticity token
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    before_action :authenticate

    def authenticate
      token =  request.headers['Authorization']

      @user = authenticate_with_http_basic do |u,p|
        User.find_by(api_key: p)
      end
      unless @user
        render status: :unprocessable_entity, json: {
          message: 'please sumbit an API token in the header'
        }
      end

    end
  end
end
