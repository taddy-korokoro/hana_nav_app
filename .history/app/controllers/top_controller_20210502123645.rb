class TopController < ApplicationController
  def home
    @q = Top.ransack(params[:q])
    @top = @q.result(distinct: true)
  end
end
