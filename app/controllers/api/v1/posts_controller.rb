require 'open-uri'

class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authorize_post, only: [:update, :destroy]

  def search
    if params[:query].present?
      posts = Post.includes(:user).search_by_title_and_body(params[:query])
      render json: posts.as_json(include: :user), status: :ok
    else
      render json: { error: 'Query parameter is required' }, status: :bad_request
    end
  end

  def index
    posts = Rails.cache.fetch('api_posts_list', expires_in: 12.hours) do
      Post.includes(:user, :comments).all
    end

    render json: posts.as_json(include: { user: { only: [:id, :email, :name] }, comments: { include: { user: { only: [:id, :email, :name] } } } }), status: :ok
  end

  def show
	  post = Post.includes(:user, :comments).find(params[:id])
	  render json: post.as_json(include: { user: { only: [:id, :email, :name] }, comments: { include: { user: { only: [:id, :email, :name] } } } }), status: :ok
	end

  def create
  post = current_user.posts.build(post_params)

  if post.save
    # Attach the uploaded image file if it exists
    if post_params[:image].present?
      post.image.attach(post_params[:image])
      post.update(image_url: post.image.url)
    end

    Rails.cache.delete('api_posts_list') # Expire the cached posts list

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

  def authorize_post
    authorize @post
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
