class SpotsController < ApplicationController
  def index
    # 検索実行
    @q = Spot.ransack(params[:q])
    binding.pry
    @spots = @q.result(distinct: true)
    @q = FlowerItem.ransack(params[:q])
    @flower_items = @q.result(distinct: true)
    # @seasons = Season.all
  end

  def search
    # 検索結果
    @q = Spot.search(search_params)
    @spots = @q.result(distict: true)

    @q = FlowerItem.search(search_params)
    @flower_items = @q.result(distict: true)
  end

  private
    def search_params
      params.require(:q).permit!
    end
end
