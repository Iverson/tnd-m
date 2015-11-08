class LicensesController < ApplicationController
  authorize_resource :license
  before_action :set_license, only: [:show, :edit, :update, :destroy]

  def index
    @licenses = License.all
  end

  def show
  end

  def new
    @license = License.new
  end

  def edit
  end

  def create
    @license = License.new(license_params)

    respond_to do |format|
      if @license.save
        format.html { redirect_to licenses_url, notice: t('.success') }
        format.json { render :show, status: :created, location: @license }
      else
        format.html { render :new }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|

      if @license.update(license_params)
        format.html { redirect_to edit_license_url(@license), notice: t('.success') }
        format.json { render :show, status: :ok, location: @license }
      else
        format.html { render :edit }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @license.destroy
    respond_to do |format|
      format.html { redirect_to licenses_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  def set_license
    @license = License.find(params[:id])
  end

  def license_params
    params.require(:license).permit(:name)
  end
end
