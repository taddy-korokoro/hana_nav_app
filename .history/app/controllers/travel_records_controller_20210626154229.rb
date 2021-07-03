class TravelRecordsController < ApplicationController
  # deviseのメソッドで「ログインしていないユーザーをログイン画面に送る」メソッド
  before_action :authenticate_user!
  before_action :set_travel_record, only: %i[edit show update destroy]


  def index
    @travel_records = TravelRecord.all.page(params[:page]).per(2).order(created_at: :desc)

    @comments = @travel_record.comments.order(created_at: :desc)
  end

  def new
    @travel_record = TravelRecord.new
  end

  def create
    @travel_record = TravelRecord.new(travel_record_params)
    # user_idの情報はフォームからはきていないので、deviseのメソッドを使って「ログインしている自分のid」を代入
    @travel_record.user_id = current_user.id
    if @travel_record.save
      redirect_to travel_record_path(@travel_record.id), notice: "投稿に成功しました。"
    else
      render :new
    end
  end

  def edit
    if @travel_record.user != current_user
      redirect_to travel_records_path, alert: "不正なアクセスです。"
    end
  end

  def show
    @user = @travel_record.user
    # 新着順で表示
    @comments = @travel_record.comments.order(created_at: :desc)
    # コメントの作成
    @comment = Comment.new
  end

  def update
    if @travel_record.update(travel_record_params)
      redirect_to travel_record_path(@travel_record.id), notice: "更新に成功しました。"
    else
      render :edit
    end
  end

  def destroy
    @travel_record.destroy
    redirect_to travel_records_path, notice: "削除に成功しました。"
  end

  private
    def travel_record_params
      params.require(:travel_record).permit(:title, :content, :place, :review,
        :visited_on, :image_1, :image_2, :image_3, :remove_image_1, :remove_image_2, :remove_image_3,
        :image_1_cache, :image_2_cache, :image_3_cache, :latitude, :longitude)
    end
    def set_travel_record
      @travel_record = TravelRecord.find(params[:id])
    end
end
