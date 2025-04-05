class RepostsController < ApplicationController
  before_action :find_post

  def create
    post = Post.find(params[:post_id])
    repost = post.reposts.build(user: current_user)

    if repost.save
      redirect_to post_path(post), notice: "Post repostado com sucesso!"
    else
      redirect_to post_path(post), alert: "Você já repostou este post."
    end
  end

  def destroy
    repost = current_user.reposts.find_by(post_id: params[:post_id])
    if repost
      repost.destroy
      redirect_to posts_path, notice: "Repost removido com sucesso!"
    else
      redirect_to posts_path, alert: "Você não pode remover este repost."
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
