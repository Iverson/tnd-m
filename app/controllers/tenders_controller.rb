class TendersController < ApplicationController
  load_and_authorize_resource :tender
  before_action :set_tender, only: [:show, :edit, :update, :destroy]

  def index
    @tenders = Tender.all
  end

  def show
    @vote = @tender.votes.find_or_initialize_by(user_id: current_user.id)
    @colleagues_votes = @tender.votes.order(value: :desc)
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
  def set_tender
    @tender = Tender.find(params[:id])
  end
end
