class TopController < ApplicationController
  def home
    @spot = Spot.find(params[:id])
  end
end
