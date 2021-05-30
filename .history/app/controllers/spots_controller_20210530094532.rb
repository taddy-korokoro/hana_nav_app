class SpotsController < ApplicationController
  def index
    # 検索実行
    # @flower_items = FlowerItem.new
    @q = FlowerItem.ransack(params[:q])
    @flower_items = @q.result
  end

  def search
    # 検索結果
    @q = Spot.ransack(search_params)
    @flower_item_spots = @q.result.includes(:area, :flower_items, :flower_item_spots)
  end

  def show
    @spot = Spot.find(params[:id])
  end

  private
    def search_params
      params.require(:q).permit!
    end
end
