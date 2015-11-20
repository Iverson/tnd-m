class VotesController < ApplicationController
  before_action :set_tender, only: [:create, :update]

  def create
    vote
  end

  def update
    vote
  end

  def vote
    @vote.update(vote_params)
    referer = request.referer

    @vote.tender.check_pre_sale if vote_params[:value] == "true" && current_user.is_admin?
    referer += "##{@vote.tender.id}" if referer.split("?")[0] == tenders_url

    respond_to do |format|
      format.html { redirect_to referer, notice: 'Вы успешно проголосовали.' }
      format.json { head :no_content }
    end
  end

  private
  def set_tender
    @tender = Tender.find(params[:tender_id])
    @vote   = @tender.votes.find_or_initialize_by(user_id: current_user.id)
  end

  def vote_params
    params.require(:tender_vote).permit(:value)
  end
end
