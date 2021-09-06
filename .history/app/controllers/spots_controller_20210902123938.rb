class SpotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot, only: %i[show update destroy photos placards map]
  before_action :set_travel_records, only: %i[show photos placards map]
  before_action :review_average, only: %i[show photos placards map]

  def show
  end

  def photos
    # 画像の投稿がない投稿のみを取得
    @photos = @travel_records.includes(:user).where.not(image_1: nil).page(params[:page]).per(6).order(created_at: :desc)
  end

  def placards
    @placards = @travel_records.includes(:user).page(params[:page]).per(3).order(created_at: :desc)
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