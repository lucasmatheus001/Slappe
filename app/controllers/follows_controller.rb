class FollowsController < ApplicationController
  def create
    user = User.find(params[:id])
    current_user.following << user unless current_user.following?(user)
    redirect_back fallback_location: user_path(user)
  end

  def destroy
    user = User.find(params[:id])
    current_user.following.delete(user)
    redirect_back fallback_location: user_path(user)
  end
end
