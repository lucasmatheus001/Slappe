class PostLikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.post_likes.build(user: current_user)

    if @like.save
      respond_to do |format|
        format.html { redirect_to posts_path, notice: "Post curtido!" }
        format.turbo_stream
      end
    else
      redirect_to posts_path, alert: "Você já curtiu este post."
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.post_likes.find_by(user: current_user)

    if @like
      @like.destroy
      respond_to do |format|
        format.html { redirect_to posts_path, notice: "Curtida removida!" }
        format.turbo_stream
      end
    else
      redirect_to posts_path, alert: "Erro ao remover curtida."
    end
  end
end
