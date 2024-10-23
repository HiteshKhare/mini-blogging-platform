# app/controllers/api/v1/posts_controller.rb
class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_post, only: [:show, :update, :destroy]

	def index
	  posts = Post.includes(:user, :comments).all
	  render json: posts.as_json(include: { user: { only: [:id, :email, :name] }, comments: { include: { user: { only: [:id, :email, :name] } } } }), status: :ok
	end

  def show
	  post = Post.includes(:user, :comments).find(params[:id])
	  render json: post.as_json(include: { user: { only: [:id, :email, :name] }, comments: { include: { user: { only: [:id, :email, :name] } } } }), status: :ok
	end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { error: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    render json: { message: 'Post deleted successfully' }, status: :ok
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
