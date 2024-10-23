class NotificationMailer < ApplicationMailer
  def comment_notification(comment)
    @comment = comment
    @post = @comment.post
    @user = @post.user

    # Mock email sending process
    mail(to: @user.email, subject: 'New Comment on Your Post') do |format|
      format.text { render plain: "New comment: #{@comment.body}" }
    end
  end
end

