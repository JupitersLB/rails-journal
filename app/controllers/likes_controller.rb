class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @like.user = current_user
    @like.likeable = @like.post
    authorize @like
    @like.save
    respond_to do |format|
      format.js { @like }
    end
  end

  private

  def like_params
    params.permit(:value, :post_id, :likeable_type, :likeable_id)
  end
end
