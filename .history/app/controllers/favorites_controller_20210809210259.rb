class FavoritesController < ApplicationController
  def create
    @spot = Spot.find(params[:spot_id])
    unless @spot.favorited_by?(current_user)
      favorite = current_user.favorites.new(spot_id: @spot.id)
      favorite.save
    end
  end

  def destroy
    @spot = Spot.find(params[:spot_id])
    favorite = current_user.favorites.find_by(spot_id: @spot.id)
    favorite.destroy
  end
end
