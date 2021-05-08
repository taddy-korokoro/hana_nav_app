class SpotsController < ApplicationController
  def index
    # 検索実行
    @q = Spot.search
    @spots = @q.result(distict: true)
  end

  def search
    
  end
end
