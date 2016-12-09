class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :require_login

  def log_in_user!(user)
    session[:session_token] = user.session_token
  end

  def logged_in?
    return false if session[:session_token].nil?
    session[:session_token] == current_user.session_token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_out
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_url # halts request cycle
    end
  end

end
