module SessionsHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    return true if session[:logged_in?] = true
  end

  def start_session
  end
end
