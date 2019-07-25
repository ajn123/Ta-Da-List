# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new; end

  # Log in user
  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      render status: :ok, json: { user_id: session[:user_id], user: user }
    else
      render status: :unprocessable_entity, json: { message: 'login failed' }
    end
  end

  def status
    respond_to do |format|
      if session[:user_id]
        format.json { render json: { user_id: session[:user_id], user: User.find(session[:user_id]) } }
      else
        format.json { render status: :not_found, json: { user_id: session[:user_id] } }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    render status: :ok, json: { message: 'Session destroyed' }
  end

  private
end
