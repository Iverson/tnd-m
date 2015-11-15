class TendersController < ApplicationController
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource :tender
  before_action :set_tender, only: [:show, :edit, :update, :destroy]

  def index
    sort = sort_column ? sort_column + " " + sort_direction : {important: :desc, necessary: :desc, created_at: :asc}
    @tenders    = Tender.order(sort)
    @performers = Performer.all
  end

  def show
    @vote = @tender.votes.find_or_initialize_by(user_id: current_user.id)
    @colleagues_votes = @tender.votes.order(value: :desc)

    if can? :manage, TenderLicense
      @licenses = License.all
      @tender.licenses.build
    end

    @tender.beneficiary || @tender.build_beneficiary
  end

  def update
    authorize! :assign_vgo, Tender unless tender_params[:is_vgo].blank?
    authorize! :assign_important, Tender unless tender_params[:important].blank?
    @tender.update(tender_params)
    @tender.check_pre_sale if tender_params[:necessary] == "1" && current_user.is_admin?

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Данные сохранены.' }
      format.json { head :no_content }
    end
  end

  # DELETE /tenders/1
  # DELETE /tenders/1.json
  def destroy
    @tender.destroy
    respond_to do |format|
      format.html { redirect_to tenders_url, notice: 'Тендер успешно удален.' }
      format.json { head :no_content }
    end
  end

  def export
    @tenders = Tender.all

    respond_to do |format|
      format.csv { send_data @tenders.to_csv }
      format.xls
    end
  end

  def import
    file = params[:file]

    if file
      if File.extname(file.path) == ".xls"
        xls = Roo::Spreadsheet.open(file.path)
        i = 1

        while !xls.row(i)[0].is_a?(Numeric) && i < xls.last_row
          i += 1
        end
        first_row = i+1

        if first_row <= xls.last_row
          (first_row..xls.last_row).each do |i|
            params = Tender.xls_to_params(xls.row(i))

            tender = Tender.find_or_initialize_by(seldon_id: params[:seldon_id])
            tender.update(params)
          end
          flash[:notice] = "Импортировано #{xls.last_row-first_row+1} записей"
        else
          flash[:error] = 'В файле нет записей'
        end
      else
        flash[:error] = 'Импортировать можно только .xls файлы'
      end
    else
      flash[:error] = 'Выберите файл'
    end

    redirect_to tenders_path
  end

  private

  def sort_column
    Tender.column_names.include?(params[:sort]) ? params[:sort] : nil
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def set_tender
    @tender = Tender.find(params[:id])
  end

  def tender_params
    params.require(:tender).permit(:performer_id, :important, :necessary, :is_vgo, licenses_attributes: [:id, :license_id, :tender_id, :available, :analog, :_destroy], beneficiary_attributes: [:id, :disclosed, :comment])
  end
end
