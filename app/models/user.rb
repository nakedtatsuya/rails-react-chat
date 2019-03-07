# frozen_string_literal: true

class User < ApplicationRecord
  has_many :friendships_of_from_user, :class_name => 'Friendship', :foreign_key => 'from_user_id', :dependent => :destroy
  has_many :friendships_of_to_user, :class_name => 'Friendship', :foreign_key => 'to_user_id', :dependent => :destroy
  has_many :friends_of_from_user, :through => :friendships_of_from_user, :source => 'to_user'
  has_many :friends_of_to_user, :through => :friendships_of_to_user, :source => 'from_user'
  has_many :from_messages, :class_name => 'Message', :foreign_key => 'from_id', :dependent => :destroy
  has_many :to_messages, :class_name => 'Message', :foreign_key => 'to_id', :dependent => :destroy
  mount_uploader :image, ImageUploader
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true

  def friends
    self.friends_of_from_user.select("users.id, users.name, users.image, is_read as isRead").joins('LEFT JOIN messages m on m.to_id=15 AND m.from_id=users.id AND m.is_read=false').group('users.id')
  end

  #selfが送るメッセージ
  def from_message(to_id)
    self.from_messages.where(to_id: to_id)
  end
  #selfが受け取るメッセージ
  def to_message(from_id)
    self.to_messages.where(from_id: from_id)
  end

  def chat_list(id)
    self.from_messages.where(to_id: id).or(self.to_messages.where(from_id: id)).order("created_at")
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

  def attributes_with_virtual(is_read)
    attributes.merge("isRead" => is_read)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
end
