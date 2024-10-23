# app/controllers/api/v1/comments_controller.rb
class Api::V1::CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user!

  def index
    comments = @post.comments.page(params[:page]).per(10)
    render json: comments.as_json, status: :ok
  end

  def show
    render json: @comment.as_json, status: :ok
  end

  def create
    comment = @post.comments.build(comment_params)

    if comment.save
      CommentNotificationJob.perform_later(comment)
      render json: comment, status: :created
    else
      render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: { message: 'Comment deleted successfully' }, status: :ok
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
