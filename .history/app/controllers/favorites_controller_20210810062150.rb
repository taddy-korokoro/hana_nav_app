class FavoritesController < ApplicationController
  def create
    @spot = Spot.find(params[:spot_id])
    unless @spot.favorited_by?(current_user)
      @favorite = Favorite.create(user_id: current_user.id, spot_id: @spot.id)
    end
  end

  def destroy
    @spot = Spot.find(params[:spot_id])
    @favorite = Favorite.find_by(user_id: current_user.id, spot_id: @spot.id)
    favorite.destroy
  end
end
