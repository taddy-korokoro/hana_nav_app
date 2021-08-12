class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def travel_record
    @user = User.find(params[:id])
    @travel_records = @user.travel_records.page(params[:page]).per(5).order(created_at: :desc)
  end
end
