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
    # @travel_record = TravelRecord.new(travel_record_params)
    # # user_idの情報はフォームからはきていないので、deviseのメソッドを使って「ログインしている自分のid」を代入
    # @travel_record.user_id = current_user.id
    # @travel_record.save
    # redirect_to travel_records_path
    travel_record_params[:images].each do |image|
      @travel_record = TravelRecord.new(travel_record_params.clone.meage({images: image}))
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
    @travel_record.destroy
    redirect_to travel_records_path
  end

  private
    def travel_record_params
      params.require(:travel_record).permit(:title, :content, :place, :review,
        :visited_on, {images: []}, :images_cache, :remove_images, :latitude, :longitude)
    end
    def set_travel_record
      @travel_record = TravelRecord.find(params[:id])
    end
end
