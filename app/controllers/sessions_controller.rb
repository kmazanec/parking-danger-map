class SessionsController < ApplicationController

 skip_before_filter :require_login

 def create
    
  user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      
      redirect_to user_path(current_user)
    else
      @error = "incorrect email or password"

      render :new
    end
  end

  def destroy
    session.clear
    # session[:logged_in?] = nil

    redirect_to root_path
  end
end
