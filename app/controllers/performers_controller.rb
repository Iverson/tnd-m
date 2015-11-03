class PerformersController < ApplicationController
  load_and_authorize_resource :performer, except: :create
  before_action :set_performer, only: [:show, :edit, :update, :destroy]

  # GET /performers
  # GET /performers.json
  def index
    @performers = Performer.all
  end

  # GET /performers/1
  # GET /performers/1.json
  def show
  end

  # GET /performers/new
  def new
    @performer = Performer.new
  end

  # GET /performers/1/edit
  def edit
  end

  # POST /performers
  # POST /performers.json
  def create
    @performer = Performer.new(performer_params)

    respond_to do |format|
      if @performer.save
        format.html { redirect_to performers_url, notice: 'Исполнитель успешно создан.' }
        format.json { render :show, status: :created, location: @performer }
      else
        format.html { render :new }
        format.json { render json: @performer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performers/1
  # PATCH/PUT /performers/1.json
  def update
    respond_to do |format|
      if @performer.update(performer_params)
        format.html { redirect_to edit_performer_url(@performer), notice: 'Исполнитель успешно обновлен.' }
        format.json { render :show, status: :ok, location: @performer }
      else
        format.html { render :edit }
        format.json { render json: @performer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performers/1
  # DELETE /performers/1.json
  def destroy
    @performer.destroy
    respond_to do |format|
      format.html { redirect_to performers_url, notice: 'Исполнитель успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
  def set_performer
    @performer = Performer.find(params[:id])
  end

  def performer_params
    params.require(:performer).permit(:name, :position, :email)
  end
end
