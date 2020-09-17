class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
    authorize @comment
    if @comment.save
      Notification.create(recipient: @comment.post.user, actor: current_user, action: "commented", notifiable: @comment.post)
      redirect_to post_path(Post.find(params[:post_id]))
    else
      render template: "posts/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    authorize @comment
    redirect_to post_path(Post.find(params[:post_id]))
  end

  private

  def comment_params
    params.require(:comment).permit(:note)
  end
end
