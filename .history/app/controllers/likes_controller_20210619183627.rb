class LikesController < ApplicationController
  def create
    @likes = current_user.likes.create(travel_record_id: params[:travel_record_id])
    redirect_back(fallback_location: root_path)
  end
end
