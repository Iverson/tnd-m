class UsersController < ApplicationController
  load_and_authorize_resource :user, except: :create
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(message_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'Пользователь успешно создан.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(message_params)
        format.html { redirect_to edit_user_url(@user), notice: 'Пользователь успешно обновлен.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Пользователь успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
  def set_message
    @user = User.find(params[:id])
  end

  def message_params
    params[:password_confirmation] = params[:password] if params[:password]
    params.require(:user).permit(:name, :position, :email, :password, :password_confirmation, :role)
  end
end
