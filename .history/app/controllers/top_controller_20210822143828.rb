class TopController < ApplicationController
  def home
  end

  def index
    # ransackの検索実行前
    @q = Spot.ransack(params[:q])
    @spots = @q.result.page(params[:page]).per(3)
    @flower_items = FlowerItem.all
    # 現在の月を格納
    @current_month = Date.today.month
    @spot = Spot.where(season_id: @current_month)
  end

  def search
    # ransackの検索結果
    @q = Spot.ransack(search_params)
    @spots = @q.result.page(params[:page]).per(3)

    @flower_item = @spots.first if @spots.present?
  end

  private
    def search_params
      params.require(:q).permit(:seasons_month_name_eq,
        :flower_items_name_eq, :area_name_eq, :name_or_location_or_flower_items_name_cont)
    end
end
