class TravelRecordsController < ApplicationController
  # deviseのメソッドで「ログインしていないユーザーをログイン画面に送る」メソッド
  before_action :authenticate_user!
  before_action :set_travel_record, only: %i[edit show update destroy]


  def index
    @travel_records = TravelRecord.all
  end

  def new
    @travel_record = TravelRecord.new
  end

  def create
    @travel_record = TravelRecord.new(travel_record_params)
    # user_idの情報はフォームからはきていないので、deviseのメソッドを使って「ログインしている自分のid」を代入
    @travel_record.user_id = current_user.id
    @travel_record.save
    redirect_to travel_records_path
  end

  def edit

  end

  def show
    @user = @travel_record.user
  end

  def update
    @travel_record.update(travel_record_params)
    if @travel_record.save
      redirect_to travel_record_path(@travel_record.id)
    else
      render :edit
    end
  end

  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting image" unless @travel_record.save
    redirect_to travel_records_path
    /@travel_record.destroy
    /redirect_to travel_records_path
  end

  private
    def add_more_images(new_images)
      images = @travel_record.images
      images += new_images
      @travel_record.images = images
    end
    def remove_image_at_index(index)
      remain_images = @travel_record.images
      if index == 0 && @travel_record.images.size == 1
        @travel_record.remove_images!
      else
        deleted_image = remain_images.delete_at(index)
        deleted_image.try(:remove!)
        @travel_record.images = remain_images
      end
    end
    def travel_record_params
      params.require(:travel_record).permit(:title, :content, :place, :review,
        :visited_on, {images: []}, :images_cache, :remove_images, :latitude, :longitude)
    end
    def set_travel_record
      @travel_record = TravelRecord.find(params[:id])
    end
end
