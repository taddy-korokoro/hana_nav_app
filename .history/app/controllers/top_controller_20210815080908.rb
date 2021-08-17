class TopController < ApplicationController
  def home
  end

  def index
    # ransackの検索実行前
    @q = Spot.ransack(params[:q])
    @spots = @q.result

    @flower_items = FlowerItem.all
  end

  def search
    # ransackの検索結果
    @q = Spot.ransack(search_params)
    @spots = @q.result
  end
end