class UsersController < ApplicationController

  def index
    @user = User.all
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: { status: 'ERROR', message: 'user not saved', data: @user.errors }
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(product: params[:product])
    render json: @user
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      head :no_content, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :passwordConfirms)
    end

end
