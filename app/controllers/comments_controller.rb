class CommentsController < ApplicationController
  before_action :find_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    authorize @comment
    if @comment.save
      unless @comment.commentable.user == current_user
        Notification.create(recipient: @comment.post.user, actor: current_user, action: "commented", notifiable: @comment.post)
      end
      @comment.commentable.comments.each { |comment| Notification.create(recipient: comment.user, actor: current_user, action: "commented", notifiable: @comment.post) if comment.user != current_user}
      redirect_to post_path(Comment.find_post(@comment))
    else
      render template: "posts/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = Comment.find_post(@comment)
    @comment.destroy
    authorize @comment
    redirect_to post_path(post)
  end

  private

  def comment_params
    params.require(:comment).permit(:note)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end
end
