class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  def index
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(2)
    @reposts = Repost.includes(:user, :post).order(created_at: :desc).page(params[:page]).per(2)
    @post = Post.new
    @indications = User.where.not(id: current_user.id).order("RANDOM()").limit(10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :content, images: [])
  end
end
