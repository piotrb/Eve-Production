class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?

  def signed_in?
    !!current_user
  end

private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
