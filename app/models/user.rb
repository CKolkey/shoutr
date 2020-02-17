# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User
  validates :username, presence: true, uniqueness: true

  has_many :shouts, dependent: :destroy
  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout

  has_many :followed_user_relationships, 
    foreign_key: :follower_id, 
    counter_cache: :followers_count,
    class_name: "FollowingRelationship",
    dependent: :destroy
  has_many :followed_users, through: :followed_user_relationships, counter_cache: :followed_users_count

  has_many :follower_relationships, 
    foreign_key: :followed_user_id, 
    class_name: "FollowingRelationship",
    dependent: :destroy
  has_many :followers, through: :follower_relationships

  def like(shout)
    liked_shouts << shout
  end

  def liked?(shout)
    liked_shout_ids.include?(shout.id)
  end

  def unlike(shout)
    liked_shouts.destroy(shout)
  end

  def to_param
    username
  end

  def follow(user)
    followed_users << user
  end

  def following?(user)
    followed_user_ids.include?(user.id)
  end

  def unfollow(user)
    followed_users.delete(user)
  end
end
