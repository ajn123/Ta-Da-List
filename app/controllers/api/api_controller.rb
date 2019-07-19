# frozen_string_literal: true

module Api
  # class
  class ApiController < ApplicationController

    # Protect from forgery skips the need to verify authenticity token
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
  end
end
