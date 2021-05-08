class SpotsController < ApplicationController
  def index
    # 検索実行
    @q = Spot.ransack(params[:q])
    @spots = @q.result.includes(:area, :flower_items, :flower_item_spots)
    @flower_items = @q.result.includes(:season, :spots)
  end

  def search
    # 検索結果
    @q = Spot.ransack(search_params)
    @spots = @q.result.includes(:area, :flower_items, :flower_item_spots)
    @flower_items = @q.result.includes(:season, :spots)
  end

  private
    def search_params
      params.require(:q).permit!
    end
end
