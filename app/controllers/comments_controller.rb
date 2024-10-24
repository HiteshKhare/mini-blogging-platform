class CommentsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    
    if @comment.save
      # Enqueue the job to send notification
      CommentNotificationJob.perform_later(@comment)

      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'Comment could not be created.'
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@comment.post), notice: 'Comment was successfully destroyed.'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

