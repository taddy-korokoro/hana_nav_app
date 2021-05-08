class SpotsController < ApplicationController
  def index
    # 検索実行
    @q = Spot.ransack(params[:q])
    @seasons = Season.all
    @spots = @q.result(distinct: true)

    @q = FlowerItem.ransack(params[:q])
    @flower_items = @q.result(distinct: true)
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
      params.require(:q).permit(:season_id_eq)
    end
end
