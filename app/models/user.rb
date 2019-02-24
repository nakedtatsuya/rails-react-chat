# frozen_string_literal: true

class User < ApplicationRecord
  has_many :friendships_of_from_user, :class_name => 'Friendship', :foreign_key => 'from_user_id', :dependent => :destroy
  has_many :friendships_of_to_user, :class_name => 'Friendship', :foreign_key => 'to_user_id', :dependent => :destroy
  has_many :friends_of_from_user, :through => :friendships_of_from_user, :source => 'to_user'
  has_many :friends_of_to_user, :through => :friendships_of_to_user, :source => 'from_user'
  has_many :from_messages, :class_name => 'Message', :foreign_key => 'from_id', :dependent => :destroy
  has_many :to_messages, :class_name => 'Message', :foreign_key => 'to_id', :dependent => :destroy

  def friends
    self.friends_of_from_user
  end

  def from_message(to_id)
    self.from_messages.where(to_id: to_id)
  end

  def to_message(from_id)
    self.to_messages.where(from_id: from_id)
  end

  def follow(other_user)
    self.friends_of_from_user << other_user
    self.friends_of_to_user << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    self.friendships_of_from_user.find_by(to_user_id: other_user.id).destroy
    self.friendships_of_to_user.find_by(from_user_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    self.friends_of_from_user.include?(other_user) || self.friends_of_to_user.include?(other_user)
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
end
