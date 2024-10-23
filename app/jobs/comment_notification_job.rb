# app/jobs/comment_notification_job.rb
class CommentNotificationJob < ApplicationJob
  queue_as :default

  def perform(comment)
    NotificationMailer.comment_notification(comment).deliver_later
  end
end
