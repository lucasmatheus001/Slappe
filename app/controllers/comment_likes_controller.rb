class CommentLikesController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    @like = @comment.comment_likes.build(user: current_user)

    if @like.save
      respond_to do |format|
        format.html { redirect_to posts_path, notice: "comment curtido!" }
        format.turbo_stream
      end
    else
      redirect_to posts_path, alert: "Você já curtiu este comment."
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @like = @comment.comment_likes.find_by(user: current_user)

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
