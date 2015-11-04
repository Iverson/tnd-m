class Milestones::CommentsController < CommentsController
  before_action :set_commentable

  private

  def commentable_path
    tender_milestone_path(@commentable.tender_id, @commentable)
  end

  def set_commentable
    @commentable = Milestone.find(params[:milestone_id])
  end
end