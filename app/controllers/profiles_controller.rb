class ProfilesController < ApplicationController

  before_filter :require_login
  before_filter :fetch_profile

  def show
  end

  def edit
  end

  def update
    @profile.update(profile_params)
    flash[:notice] = "Profile Saved"
    redirect_to action: :show
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :username, :password, :password_confirmation)
  end

  def fetch_profile
    @profile = Profile.from(current_user)
  end

end
