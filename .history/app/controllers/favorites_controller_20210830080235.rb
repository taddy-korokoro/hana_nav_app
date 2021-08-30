class FavoritesController < ApplicationController
  def create
    @spot = Spot.find(params[:spot_id])
    unless @spot.favorited_by?(current_user)
      current_user.favorites.create(spot_id: @spot.id)
    end
    flash.now[:notice] = "お気に入りに登録しました。"
  end

  def destroy
    @spot = Spot.find(params[:spot_id])
    favorite = current_user.favorites.find_by(spot_id: @spot.id)
    favorite.destroy
    flash.now[:warning] = "お気に入りを解除しました。"
  end
end
