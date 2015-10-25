class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    @comment.save

    redirect_to @commentable, notice: "Комментарий добавлен."
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end