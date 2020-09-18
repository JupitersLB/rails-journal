class RelationshipsController < ApplicationController
  before_action :find_friend_request, only: [:accept, :decline, :cancel]

  def index
    skip_policy_scope
    @friends = current_user.friends
    @pending_requests = current_user.friend_requests_as_requestor.where(status: "pending").flat_map(&:receiver)
    @pending_requests_received = current_user.friend_requests_as_receiver.where(status: "pending").flat_map(&:requestor)
  end

  def create
    friend = FriendRequest.new(requestor: current_user, receiver: User.find(params[:format]))
    authorize friend
    if friend.save
      Notification.create(recipient: friend.receiver, actor: friend.requestor, action: "requested", notifiable: friend)
      redirect_to relationships_path
    else
      render :search
    end
  end

  def search
    @search_results = User.search_by_username(params[:search])
    @friend_request = FriendRequest.new
    authorize @friend_request
  end

  def accept
    friendship = Friendship.new(friend_a: @friend_request.requestor, friend_b: current_user)
    friendship.save
    @friend_request.status = "accepted"
    @friend_request.save
    authorize @friend_request
    redirect_to relationships_path
  end

  def cancel
    @friend_request.destroy
    authorize @friend_request
    redirect_to relationships_path
  end

  def decline
    @friend_request.destroy
    authorize @friend_request
    redirect_to relationships_path
  end

  private

  def find_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
