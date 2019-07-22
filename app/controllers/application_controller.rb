# frozen_string_literal: true

class ApplicationController < ActionController::Base


  def index
    render 'layouts/application.html.erb'
  end



  def logged_in?
    session[:user_id] != nil
  end


  def current_user
    User.find(session[:user_id])
  end


  helper_method :logged_in?
  helper_method :current_user
end
