class TopController < ApplicationController
  before_action :authenticate_user!, only: %i[index search]
  def home
    redirect_to :index if user_signed_in?
  end

  def index
    # 現在月のflower_itemとspotの表示設定
    @q = Spot.includes(:spot_seasons).where(spot_seasons: { season_id: Date.today.month }).ransack(params[:q])
    @spots = @q.result.page(params[:page]).per(5)
    @flower_items = FlowerItem.includes(:flower_item_seasons).where(flower_item_seasons: { season_id: Date.today.month })
  end

  def search
    # ransackの検索結果
    @q = Spot.ransack(search_params)
    @spots = @q.result.page(params[:page]).per(5)

    @flower_item = @spots.first if @spots.present?
  end

  private
    def search_params
      params.require(:q).permit(:seasons_month_name_eq,
        :flower_items_name_eq, :area_name_eq, :name_or_location_or_flower_items_name_cont)
    end
end
