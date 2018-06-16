class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order 'created_at DESC'
  end

  def new
    @post = Post.new
    @post.user = current_user
  end

  def create
    if !user_signed_in?
      redirect_to new_user_session_path
    end
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    if current_user != @post.user
      redirect_to @post
    end
  end

  def update
    if current_user != @post.user
      redirect_to @post
    end
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    if current_user != @post.user
      redirect_to @post
    end
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
