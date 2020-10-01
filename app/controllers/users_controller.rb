class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def addfriend
    Friendship.create(user_id: current_user.id, friend_id: params[:id], confirmed: false)
    redirect_to users_path
  end

  def cancel_request
    f = Friendship.where(user_id: current_user.id, friend_id: params[:id])
    f.destroy_all
    redirect_to users_path
  end

  def reject
    f = Friendship.where(user_id: params[:id], friend_id: current_user.id)
    f.destroy_all
    redirect_to users_path
  end

  def accept
    f = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    f.confirmed = true
    f.save
    Friendship.create(user_id: current_user.id, friend_id: params[:id], confirmed: true )
    redirect_to users_path
  end

  def unfriend
    f = current_user.friendships.where(friend_id: params[:id], confirmed: true)
    f.destroy_all
    f = Friendships.where(user_id: params[:id], friend_id: current_user.id, confirmed: true)
    f.destroy_all
    redirect_to users_path
  end
end
