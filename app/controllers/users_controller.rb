class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    authorize @user
  end
end
