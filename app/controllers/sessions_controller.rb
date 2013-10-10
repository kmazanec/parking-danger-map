class SessionsController < ApplicationController

  def new

  end

  def create
    
  @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      
      redirect_to :root
    else
      @error = "incorrect email or password"

      render :new
    end
  end

  def destroy
    session[:logged_in?] = nil

    redirect_to root_path
  end
end
