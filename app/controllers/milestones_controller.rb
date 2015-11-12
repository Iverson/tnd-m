class MilestonesController < ApplicationController
  load_and_authorize_resource :milestone, only: [:show, :new, :create, :destroy]
  before_action :set_tender
  before_action :set_milestone, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @milestone = @tender.milestones.new
    @performers = Performer.all
  end

  def edit
    authorize_update
    @performers = Performer.all
  end

  def create
    @milestone = @tender.milestones.new(milestone_params)

    respond_to do |format|
      if @milestone.save
        send_email_if_performer_set
        format.html { redirect_to tender_milestone_path(@tender, @milestone), notice: t('.success') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize_update
    current_performer_id = @milestone.performer_id

    respond_to do |format|
      if @milestone.update(milestone_params)
        send_email_if_performer_set(current_performer_id)
        format.html { redirect_to :back, notice: t('.success') }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @milestone.destroy
    respond_to do |format|
      format.html { redirect_to tender_path(@tender), notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

  def send_email_if_performer_set(current_performer_id = nil)
    UserMailer.performer_notify_email(@milestone.performer, @milestone).deliver_later if !milestone_params[:performer_id].blank? && milestone_params[:performer_id].to_i != current_performer_id
  end

  def set_tender
    @tender = Tender.find(params[:tender_id])
  end

  def set_milestone
    @milestone = Milestone.find(params[:id])
  end

  def milestone_params
    params.require(:milestone).permit(:name, :performer_id, :lead_time, :estimate_date, :tender_date, :complete_date)
  end

  def authorize_update
    if @milestone.code? "presale"
      authorize! :assign_presale, Tender if @milestone.code? "presale"
    else
      authorize! :update, Milestone
    end
  end
end
