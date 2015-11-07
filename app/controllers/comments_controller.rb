class CommentsController < ApplicationController
  authorize_resource :comment

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    @comment.save

    redirect_to commentable_path, notice: "Комментарий добавлен."
  end

  private

  def commentable_path
    @commentable
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end