class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @travel_records = @user.travel_records.page(params[:page]).per(3).order(created_at: :desc)
    # @paginate = @travel_records.page(params[:page].per(4).order(created_at: :desc)
  end
end
