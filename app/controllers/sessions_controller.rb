class SessionsController < ApplicationController


  def new
    
  end


  def create

    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
    else

    end

    redirect_to root_path
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private


end
