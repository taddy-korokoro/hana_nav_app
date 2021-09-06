class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[travel_records favorites likes followings followers feeds]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(5).order(created_at: :desc)
    @user_count = User.all.count

    @select_array =[{ id: 'id desc', name: "並び替え", {id: 'travel_records_count desc', name: "投稿数が多い順"}, {id: 'likes_count desc', name: "いいね!の多い順"}]
  end

  def search
    @q = User.search(search_params)
    @users = @q.result.page(params[:page]).per(5).order(created_at: :desc)
    # 検索一致したユーザー数を表示するためのインスタンス
    @user_count = @q.result.count
  end

  def travel_records
    @travel_records = @user.travel_records.includes(:spot).page(params[:page]).per(5).order(created_at: :desc)
  end

  def favorites
    @favorites = @user.favorites.includes(:spot).page(params[:page]).per(5).order(created_at: :desc)
  end

  def likes
    @likes = @user.likes.page(params[:page]).per(5).order(created_at: :desc)
  end

  def followings
    @users = @user.followings.page(params[:page]).per(5)
  end

  def followers
    @users = @user.followers.page(params[:page]).per(5)
  end

  def feeds
    @feed_items = @user.feed.includes(:user).page(params[:page]).per(5).order(created_at: :desc)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def search_params
      params.require(:q).permit!
    end
end
