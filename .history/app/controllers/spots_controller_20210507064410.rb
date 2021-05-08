class SpotsController < ApplicationController
  def index
    # 検索実行
    @q = Spot.ransack(params[:q])
    @spots = @q.result.includes(:area, :flower_item_spots, :flower_item_spots_flower_items)

    @q = FlowerItem.ransack(params[:q])
    @flower_items = @q.result.includes(:season, :flower_item_spots, :flower_item_spots_spots)
  end

  def search
    # 検索結果
    @q = Spot.ransack(search_params)
    @spots = @q.result(distict: true)

    @q = FlowerItem.ransack(search_params)
    @flower_items = @q.result(distict: true)
  end

  private
    def search_params
      params.require(:q).permit!
    end
end
