class CommentsController < ApplicationController
  before_action :set_post, only: :create

  def create
    @comment = @post.comments.new(comment_params)

    if @comment.save
      flash[:success] = 'Comment created successfully'
      redirect_to post_path(@post)
    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
