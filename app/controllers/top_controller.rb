class TopController < ApplicationController
  def home
    @spot = Spot.ransack
  end
end
