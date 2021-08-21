class SpotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot, only: %i[ edit show update destroy photos placards map ]
  before_action :set_travel_records, only: %i[ show photos placards map ]
  before_action :review_average, only: %i[ show photos placards map ]

  def index
    @spots = Spot.all.page(params[:page]).per(6).order(created_at: :ask)
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

  def photos
    # 画像の投稿がない投稿のみを取得
    @photos = @travel_records.where.not(image_1: nil).page(params[:page]).per(6).order(created_at: :desc)
  end

  def placards
    @placards = @travel_records.page(params[:page]).per(3).order(created_at: :desc)
  end

  def map
  end

  private
    def spot_params
      params.require(:spot).permit(:name, :location, :feature, :image,
      :image_cache, :remove_image, :url, :latitude, :longitude, :area_id)
    end

    def set_spot
      @spot = Spot.find(params[:id])
    end

    def set_travel_records
      @travel_records = @spot.travel_records
    end

    def review_average
      @review_average = @travel_records.average(:review).to_f.round(1) if @travel_records.present?
    end
end