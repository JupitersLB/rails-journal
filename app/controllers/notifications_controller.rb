class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_after_action :verify_authorized

  def index
    @notifications = policy_scope(Notification).where(recipient: current_user).order(created_at: :desc).take(8)
  end

  def mark_as_read
    @notifications = policy_scope(Notification).where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end
end
