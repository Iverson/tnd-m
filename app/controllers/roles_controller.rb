class RolesController < ApplicationController
  authorize_resource :role
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def index
    @roles = Role.all
  end

  def show
  end

  def new
    @role = Role.new ability: {}
    @ability = ABILITY
  end

  def edit
    @ability = ABILITY
  end

  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to roles_url, notice: t('.success') }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|

      if @role.update(role_params)
        format.html { redirect_to edit_role_url(@role), notice: t('.success') }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, ability: ABILITY["resources"])
  end
end
