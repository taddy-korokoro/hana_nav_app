class TopController < ApplicationController
  def home
    @q = Spot.ransack
    @spots = @q.result(distinct: true)
  end
end
