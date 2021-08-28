class TopController < ApplicationController
  before_action :authenticate_user!, only: %i[index search]
  def home
    redirect_to :index if user_signed_in?
  end

  def index
    # ransackの検索実行前
    @q = Spot.seasons.where(season_id: Date.today.month).ransack(params[:q])
    @spots = @q.result.page(params[:page]).per(5)
    @flower_items = FlowerItem.includes(flower_item_seasons: :season)
    # 現在の月を格納
    @current_month = Date.today.month
    # TODO: ページネーションの作成
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
