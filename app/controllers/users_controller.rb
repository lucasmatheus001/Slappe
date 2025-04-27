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
    @followers = @user.followers.order(created_at: :desc).page(params[:page]).per(2)
  end

  def following
    @following = @user.following.order(created_at: :desc).page(params[:page]).per(2)
  end

  def search
    if params[:query].present?
      @users = User.where("name ILIKE ?", "%#{params[:query]}%").order("RANDOM()").page(params[:page]).per(2)
    else
      @users = User.none
    end
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
