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
    byebug
    f.destroy_all
    redirect_to users_path
  end

  def accept
    f = Friendship.where(user_id: params[:id], friend_id: current_user.id).first
    f.confirmed = true
    f.save
    redirect_to users_path
  end

  def unfriend
    f = current_user.friendships.where(friend_id: params[:id], confirmed: true)
    f.destroy_all
    f = current_user.inverse_friendships.where(user_id: params[:id], confirmed: true)
    f.destroy_all
    redirect_to users_path
  end
end
