class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.includes(:user)
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:success] = 'Post was created'
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post was updated'
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post was deleted'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
