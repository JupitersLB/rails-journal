class RelationshipsController < ApplicationController
  before_action :find_friend_request, only: [:accept, :decline, :cancel]

  def index
    @friends = current_user.friends
    @pending_requestor = current_user.friend_requests_as_requestor
    @pending_receiver = current_user.friend_requests_as_receiver
  end

  def create
    friend = FriendRequest.new(requestor: current_user, receiver: User.find(params[:format]))
    if friend.save
      redirect_to relationships_path
    else
      render :search
    end
  end

  def search
    @search_results = User.search_by_username(params[:search])
    @friend_request = FriendRequest.new
  end

  def accept
    friendship = Friendship.new(friend_a: @friend_request.requestor, friend_b: current_user)
    friendship.save
    @friend_request.destroy
    raise
    redirect_to relationships_path
  end

  def cancel
    @friend_request.destroy
    raise
    redirect_to relationships_path
  end

  def decline
    @friend_request.destroy
    raise
    redirect_to relationships_path
  end

  private

  def find_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
