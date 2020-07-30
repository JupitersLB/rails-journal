class PostsController < ApplicationController
  before_action :find_post, only: [:show, :destroy]

  def index
    @my_posts = Post.where(user: current_user)
    ids = current_user.friends.pluck(:id) << current_user.id
    @all_posts = Post.where(user_id: ids)
  end

  def new
    @post = Post.new
  end

  def show; end

  def create
    @post = Post.new(post_params)
    @post.date = DateTime.now
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
