class TopController < ApplicationController
  def home
    @q = Spot.ransack
  end
end
