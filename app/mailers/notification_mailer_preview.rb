class NotificationMailerPreview < ActionMailer::Preview
  def comment_notification
    # Create a mock comment to preview
    comment = Comment.new(body: "This is a test comment", user: User.first || User.new(name: "Test User", email: "test@example.com"), post: Post.first || Post.new(title: "Test Post", body: "This is a test post"))
    NotificationMailer.comment_notification(comment)
  end
end
