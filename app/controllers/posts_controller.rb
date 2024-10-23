class PostsController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post, only: [:update, :destroy]

  def index
    if params[:query].present?
      @posts = Post.includes(:user).search_by_title_and_body(params[:query])
    else
      @posts = Post.includes(:user).all
    end
  end

  def search
    if params[:query].present?
      @posts = Post.includes(:user).search_by_title_and_body(params[:query])
      render :index
    else
      redirect_to posts_path, alert: 'Query parameter is required'
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params.except(:image))  # Build post without image parameter

    if @post.save
      if post_params[:image].present?
        @post.image.attach(post_params[:image])  # Attach the uploaded image
        @post.update(image_url: @post.image.url)  # Save the image URL to the post record
      end

      expire_fragment('posts_list') # Expire the cached posts list
      Rails.logger.info "Cache for posts list expired after creating post with ID: #{@post.id}"

      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      expire_fragment('posts_list') # Expire the cached posts list
      Rails.logger.info "Cache for posts list expired after updating post with ID: #{@post.id}"
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully destroyed.'
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
