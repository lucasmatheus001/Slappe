class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comentário adicionado!"
    else
      redirect_to @post, alert: "Erro ao adicionar comentário."
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      redirect_to @post, notice: "Comentário removido."
    else
      redirect_to @post, alert: "Você não tem permissão para excluir este comentário."
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, images: [])
  end
end
