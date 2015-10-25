class Tenders::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Tender.find(params[:tender_id])
  end
end