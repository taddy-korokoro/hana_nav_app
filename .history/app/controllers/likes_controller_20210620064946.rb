class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(travel_record_id: params[:travel_record_id])
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @travel_record = TravelRecord.find(params[:travel_record_id])
    @like = current_user.likes.find_by(travel_record_id: @travel_record.id)
    @like.destroy
    # redirect_back(fallback_location: root_path)
  end
end
