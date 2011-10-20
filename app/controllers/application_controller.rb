class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?

  def signed_in?
    !!current_user
  end

protected
  def require_login
    unless signed_in?
      redirect_to "/auth/google_oauth2"
      return false
    end
  end

private
  def current_user
    @current_user ||= User.where(:id => session[:user_id]).first if session[:user_id]
  end

end
