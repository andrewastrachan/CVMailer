class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  
  def log_in(user)
    @current_user = user
    session[:token] = user.reset_session_token!
  end
  
  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by(session_token: session[:token])
  end
  
  def logged_in?
    !!current_user
  end
  
  def redirect_if_logged_in
    redirect_to jobs_url if logged_in?
  end
  
  def redirect_unless_logged_in
    redirect_to root_path unless logged_in?
  end
  
  def log_out!
    current_user.reset_session_token!
    session[:token] = nil
  end
end
