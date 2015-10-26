class TendersController < ApplicationController
  load_and_authorize_resource :tender
  before_action :set_tender, only: [:show, :edit, :update, :destroy]

  def index
    @tenders = Tender.all
  end

  def show
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

        (5..xls.last_row).each do |i|
          row = xls.row(i)
          row.compact!
          row.shift

          params = {
            seldon_id: row[0],
            name: row[1],
            customer: row[2],
            milestones: row[3],
            url: row[4],
            start_date: row[5],
            end_date: row[6],
            start_max_price: row[7],
            docs_deadline: row[8],
            approve_deadline: row[9],
            completion_date: row[10]
          }

          tender = Tender.find_or_initialize_by(seldon_id: params[:seldon_id])
          tender.update(params)
        end
        flash[:notice] = "Импортировано #{xls.last_row-5+1} записей"
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
