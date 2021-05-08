class SpotsController < ApplicationController
  def index
    # 検索実行
    @q = Spot.search
    @spots = @q.result(distict: true)
  end

  def search
    @q = Spot.search(search_params)
    @spots = @q.result(distict: true)
  end

  private
    def search_params
      params.require(:q).permit!
    end
end
