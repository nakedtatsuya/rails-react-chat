class FriendshipsController < ApplicationController

  def create
      user = User.find(params[:to_user_id])
      current_user.follow(user)
      render json: user
  end

  def destroy
      user = Friendship.find_by(to_user_id: params[:id]).to_user
      current_user.unfollow(user)
      render json: current_user
  end
end