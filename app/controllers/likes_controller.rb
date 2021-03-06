class LikesController < ApplicationController
  def create
    @travel_record = TravelRecord.find(params[:travel_record_id])
    unless @travel_record.liked_by?(current_user)
      like = current_user.likes.create(travel_record_id: @travel_record.id)
    end
    flash.now[:notice] = "いいねしました。"
  end

  def destroy
    @travel_record = TravelRecord.find(params[:travel_record_id])
    like = current_user.likes.find_by(travel_record_id: @travel_record.id)
    like.destroy
    flash.now[:warning] = "いいねを解除しました。"
  end
end
