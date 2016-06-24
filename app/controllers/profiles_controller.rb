class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    if current_user
      render
    else
      redirect_to dashboard_path, notice: "Profile not found!"
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to edit_profile_path, notice: "Your profile has been updated."
    else
      render 'edit'
    end
  end
end
