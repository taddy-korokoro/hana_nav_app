class LikesController < ApplicationController
  def create
    @travel_record = TravelRecord.find(pramas[:travel_record_id])
    unless @travel_record.liked_by?(current_user)
      like = current_user.likes.new(travel_record_id: @travel_record.id)
      like.save
    end
    # @like = current_user.likes.create(travel_record_id: params[:travel_record_id])
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @travel_record = TravelRecord.find(params[:travel_record_id])
    like = current_user.likes.find_by(travel_record_id: @travel_record.id)
    like.destroy
    # @travel_record = TravelRecord.find(params[:travel_record_id])
    # @like = current_user.likes.find_by(travel_record_id: @travel_record.id)
    # @like.destroy
    # redirect_back(fallback_location: root_path)
  end
end
