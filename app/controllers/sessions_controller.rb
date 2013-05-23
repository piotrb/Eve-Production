class SessionsController < ApplicationController

  def create
    if request.env['omniauth.auth']
      auth = request.env["omniauth.auth"]
      token = auth["credentials"]["token"]
      conn = Faraday.new(:url => 'https://www.googleapis.com')
      response = conn.get "/oauth2/v1/userinfo?alt=json&access_token=#{token}"
      profile = JSON.load(response.body)
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth, profile)
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
    else
      user = User.where(:username => session_params[:username]).first
      if user
        if user.authenticate(session_params[:password])
          session[:user_id] = user.id
          redirect_to root_path, :success => "Logged in"
        else
          flash.now[:error] = "Login Failed"
          render :action => :new
        end
      else
        flash.now[:error] = "Login Failed"
        render :action => :new
      end
    end
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

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end

end
