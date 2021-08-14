class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[travel_record favorite like followings followers]

  def index
    @users = User.all
  end

  def travel_record
    @travel_records = @user.travel_records.page(params[:page]).per(5).order(created_at: :desc)
  end

  def favorite
    @favorites = @user.favorites.page(params[:page]).per(5).order(created_at: :desc)
  end

  def like
    @likes = @user.likes.page(params[:page]).per(5).order(created_at: :desc)
  end

  def followings
    @
  end

  def followers
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
