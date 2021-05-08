class TopController < ApplicationController
  def home
    @spot = Spot.ransack
    @user = User.find(params[:id])
  end
end
