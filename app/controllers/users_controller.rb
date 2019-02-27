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
      @user = User.find(params[:id])
      render json: @user
  end

  def friend
      id = current_user.id.to_s
      @users = User.find_by_sql('SELECT u.name,u.email,u.image,u.id,(select is_read from messages WHERE to_id='+id+' AND from_id=u.id ORDER BY created_at desc limit 1) as isRead FROM users u INNER JOIN friendships f ON u.id=f.to_user_id WHERE f.from_user_id='+id+'')
      render json: @users
  end

  def image
    if current_user.update_attributes(image: params[:image])
      render json: current_user
    else
      render status: 500
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :passwordConfirms)
    end

end
