class TopController < ApplicationController
  def home
    @q = Top.ransack(params[:q])
    @tops = @q.result(distinct: true)
  end

  def index
    @q = Top.search(search_params)
    @tops = @q.result(distinct: true)
  end

  private
  def search_params
    params.require(:q).permit!
  end
end
