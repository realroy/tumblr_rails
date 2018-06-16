class CommentsController < ApplicationController
  before_action :find_post
  def create
    @comment = @post.comments.new comment_params
    if user_signed_in?
      @comment.name = current_user.email
    end
    @comment.save
    redirect_to @post
  end
  def destroy
    if current_user != @post.user
      redirect_to @post
    end
    @comment = @post.comments.find params[:id]
    @comment.destroy
    redirect_to @post
  end
  private
  def find_post
    @post = Post.find params[:post_id]
  end
  def comment_params
    params.require(:comment).permit(:name, :body)
  end
end
