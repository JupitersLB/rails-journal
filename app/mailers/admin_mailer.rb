class AdminMailer < ApplicationMailer
  def new_user
    @user = params[:user]
    @new_user = params[:new_user]
    mail(to: @user.email, subject: '[Yours] New user registered')
  end
end
