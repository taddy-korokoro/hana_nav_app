class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[travel_records favorites likes follows followers]

  def index
    @users = User.all
  end

  def travel_records
    @travel_records = @user.travel_records.page(params[:page]).per(5).order(created_at: :desc)
  end

  def favorites
    @favorites = @user.favorites.page(params[:page]).per(5).order(created_at: :desc)
  end

  def likes
    @likes = @user.likes.page(params[:page]).per(5).order(created_at: :desc)
  end

  def follows
    @users = @user.followings.page(params[:page]).per(5)
  end

  def followers
    @users = @user.followers.page(params[:page]).per(5)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
