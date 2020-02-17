# frozen_string_literal: true

class FollowersController < ApplicationController
  def index
    @user      = find_user
    @followers = @user.followers
  end

  private

  def find_user
    @find_user ||= User.find_by(username: params[:user_id])
  end
end
