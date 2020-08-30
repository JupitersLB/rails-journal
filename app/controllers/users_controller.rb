class UsersController < ApplicationController
  def show
    unless params[:username] == 'notifications'
      @user = User.find_by_username(params[:username])
      authorize @user
    end
  end
end
