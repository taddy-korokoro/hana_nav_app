class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[travel_record favorite]

  def index
    @users = User.all
  end

  def travel_record
    @travel_records = @user.travel_records.page(params[:page]).per(5).order(created_at: :desc)
  end

  def favorite
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
