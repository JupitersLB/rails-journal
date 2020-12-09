class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    if @like.save
      flash[:success] = 'Thanks for liking!'
    else
      flash[:alert] = @like.errors.full_messages.join(', ')
  end

  private

  def like_params
    params.require(:like).permit(:value, :post_id)
  end
end
