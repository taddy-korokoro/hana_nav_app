class SpotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot, only: %i[edit show update destroy photos placards map]
  before_action :set_travel_record, only: %i[show photos placards map]

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

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      redirect_to spot_path(@spot.id)
    else
      render :new
    end
  end

  def edit
  end

  def show
    @travel_records = TravelRecord.all
  end

  def update
    @spot.update(spot_params)
    if @spot.save
      redirect_to spot_path(@spot.id)
    else
      render :edit
    end
  end

  def destroy
    @spot.destroy
    redirect_to spots_path
  end

  def photos
    @travel_records = TravelRecord.all.page(params[:page]).per(5).order(created_at: :desc)
  end

  def placards
    @travel_records = TravelRecord.all.page(params[:page]).per(3).order(created_at: :desc)
    @user = @travel_record.user
  end

  def map
  end

  private
    def search_params
      params.require(:q).permit(:flower_items_season_month_name_eq,
        :flower_items_name_eq, :area_name_eq, :name_or_location_or_flower_items_name_cont)
    end

    def spot_params
      params.require(:spot).permit(:name, :location, :feature, :image,
      :image_cache, :remove_image, :url, :latitude, :longitude, :area_id)
    end

    def set_spot
      @spot = Spot.find(params[:id])
    end

    def set_travel_record
      @travel_record = TravelRecord.find(params[:id])
    end
end