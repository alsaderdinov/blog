class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_post!

  def index
    if params[:filter] == 'my'
      @pagy, @posts = pagy(current_user.posts.for_pagination)
    else
      @pagy, @posts = pagy(Post.for_pagination)
    end
  end

  def show
    @comment = @post.comments.new
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post updated successfully'
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post deleted successfully'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post!
    authorize(@post || Post)
  end
end
