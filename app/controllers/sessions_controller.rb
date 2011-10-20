class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    token = auth["credentials"]["token"]
    conn = Faraday.new(:url => 'https://www.googleapis.com')
    response = conn.get "/oauth2/v1/userinfo?alt=json&access_token=#{token}"
    profile = JSON.load(response.body)
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth, profile)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def failure
    session[:user_id] = nil
    flash[:error] = params[:message]
    redirect_to :root
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
