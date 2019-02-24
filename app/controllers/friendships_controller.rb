class FriendshipsController < ApplicationController

  def create
    if current_user
      user = User.find(params[:to_user_id])
      current_user.follow(user)
      render json: current_user
    else
      render status: 500, json: { status: 500, message: 'Not login. Access denied. Permission error' }
    end
  end

  def destroy
    if current_user
      user = Friendship.find_by(to_user_id: params[:id]).to_user
      current_user.unfollow(user)
      render json: current_user
    else
      render status: 500, json: { status: 500, message: 'Not login. Access denied. Permission error' }
    end
  end
end