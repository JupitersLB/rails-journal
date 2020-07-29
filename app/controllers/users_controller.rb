class UsersController < ApplicationController
  def show
    @user = current_user
    ids = current_user.friends.pluck(:id) << current_user.id
    @posts = Post.where(user_id: ids)
  end
end
