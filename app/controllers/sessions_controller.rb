# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new; end

  # Log in user
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      render status: :ok, json: { user_id: session[:user_id], user: user }
    else
      render status: :unprocessable_entity, json: { message: 'login failed' }
    end
  end

  def status
    respond_to do |format|
      format.json { render json: { user_id: session[:user_id] } }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
end
