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

    respond_to do |format|
      format.html { redirect_to tender_url(@tender), notice: 'Вы успешно проголосовали.' }
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
