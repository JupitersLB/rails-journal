class PostsController < ApplicationController
  before_action :find_post, only: [:show, :destroy]

  def index
    @my_posts = policy_scope(Post).where(user: current_user)
    ids = current_user.friends.pluck(:id) << current_user.id
    @all_posts = policy_scope(Post).where(user_id: ids)
  end

  def new
    @post = Post.new
    authorize @post
  end

  def show
    @comment = Comment.new
    authorize @comment
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.date = DateTime.now
    @post.user = current_user
    authorize @post
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    authorize @post
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
