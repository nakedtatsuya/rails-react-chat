class UsersController < ApplicationController

  def index
      exclusionList = [current_user.id]
      current_user.friends.each {|user| exclusionList.push(user.id)}
      exclusionList = exclusionList.join(',')
      @user = User.where("name LIKE ? AND id NOT IN (" + exclusionList+ ")", "%"+params[:name]+"%")
      render json: @user
  end

  def show
      @user = User.find(params[:id])
      render json: @user
  end

  def friend
      render json: current_user.friends
  end

  def image
    image = current_user.image
    if params[:image] != nil
      image = params[:image]
    end
    #imageもあるとき
    if current_user.update_attributes(image: image, name: params[:name], email: params[:email])
      render json: {data: current_user}
    else
      render_error
    end

  end

  private

    def render_error
      render json: {
          status: 'error',
          errors: current_user.errors.to_hash.merge(full_messages: current_user.errors.full_messages)
      }, status: 422
    end

    def user_params
      params.require(:user).permit(:name, :email, :image, :password, :passwordConfirms)
    end

end
