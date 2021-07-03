class SpotsController < ApplicationController
  before_action :set_spot, only: [:edit, :show, :update, :destroy]

  def index
    # ransackの検索実行前
    @q = FlowerItem.ransack(params[:q])
    @flower_items = @q.result

    @spots = Spot.all
  end

  def search
    # ransackの検索結果
    @q = FlowerItem.ransack(search_params)
    @flower_items = @q.result
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

  private
    def search_params
      params.require(:q).permit!
    end

    def spot_params
      params.require(:spot).permit(:name, :location, :feature, :image,
      :image_cache, :remove_image, :url, :latitude, :longitude, :area_id)
    end

    def set_spot
      @spot = Spot.find(params[:id])
    end
end