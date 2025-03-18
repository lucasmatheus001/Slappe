class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy followers following]

  def index
    @users = User.order(id: :desc)
  end

  def show
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def followers
    @followers = @user.followers
  end

  def following
    @following = @user.following
  end

  private

  def set_user
    @user = User.find(params[:id])
    # authorize @user
  end

  def user_params
    params.required(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
