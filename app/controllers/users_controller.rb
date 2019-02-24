class UsersController < ApplicationController

  def index
    if current_user
      exclusionList = [current_user.id]
      current_user.friends.each {|user| exclusionList.push(user.id)}
      exclusionList = exclusionList.join(',')
      @user = User.where("name LIKE ? AND id NOT IN (" + exclusionList+ ")", "%"+params[:name]+"%")
      render json: @user
    else
      render status: 500, json: { status: 500, message: 'Not login. Access denied. Permission error' }
    end
  end

  def show
    if current_user
      @user = User.find(params[:id])
      render json: @user
    else
      render status: 500, json: { status: 500, message: 'Not login. Access denied. Permission error' }
    end
  end

  def friend
    if current_user
      @users = current_user.friends
      render json: @users
    else
      render status: 500, json: { status: 500, message: 'Not login. Access denied. Permission error' }
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :passwordConfirms)
    end

end
