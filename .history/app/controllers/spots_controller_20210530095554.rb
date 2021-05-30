class SpotsController < ApplicationController
  def index
    # 検索実行
    # @flower_items = FlowerItem.new
    @q = FlowerItem.ransack(params[:q])
    @flower_items = @q.result
  end

  def search
    # 検索結果
    @q = FlowerItem.ransack(search_params)
    @flower_items = @q.result
  end

  def show
    @spot = Spot.find(params[:id])
  end

  private
    def search_params
      params.require(:q).permit!
    end
end
