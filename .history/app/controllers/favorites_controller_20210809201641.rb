class FavoritesController < ApplicationController
  def create
    @spot = Spot.find(params[:id])
    unless @spot.favorited_by?(current_user)
      favorite = current_user.favorites.create(spot_id: @spot.id)
    end
  end

  def destroy
    @spot = Spot.find(params[:id])
    favorite = current_user.favorites.find_by(spot_id: @spot.id)
    favorite.destroy
  end
end
