class ApplicationController < ActionController::Base
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  helper_method :current_user
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  before_filter :require_login #, :id_check

  def require_login
    unless current_user
      flash[:notice] = "Please log in or sign up in order to view that page."
      redirect_to root_url
    end
  end

end
