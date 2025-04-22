class FollowsController < ApplicationController
  before_action :set_user

  def create
    if current_user.following.include?(@user)
      flash[:notice] = "Você já segue este usuário."
    else
      current_user.following << @user
      flash[:success] = "Agora você está seguindo #{@user.name}."
    end
    redirect_to root_path
  end

  def destroy
    if current_user.following.include?(@user)
      current_user.following.delete(@user)
      flash[:success] = "Você deixou de seguir #{@user.name}."
    else
      flash[:notice] = "Você não segue este usuário."
    end
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
