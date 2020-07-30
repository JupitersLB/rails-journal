class PostsController < ApplicationController
  def index
    @my_posts = Post.where(user: current_user)
    ids = current_user.friends.pluck(:id) << current_user.id
    @all_posts = Post.where(user_id: ids)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :date)
  end
end
