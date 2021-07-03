class TravelRecordsController < ApplicationController
  # deviseのメソッドで「ログインしていないユーザーをログイン画面に送る」メソッド
  before_action :authenticate_user!
  before_action :set_travel_record only: [:edit, :show, :update, :destroy]


  def index
    @travel_records = TravelRecord.all
  end

  def new
    @travel_record = TravelRecord.new
  end

  def create
    @travel_record = TravelRecord.new(travel_record_params)
    @travel_record.user_id = current_user.id
    @travel_record.set_travel_record
    redirect_to travel_records_path
  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end

  private
    def set_travel_record
      @travel_record = TravelRecord.find(params[:id])
    end
end
