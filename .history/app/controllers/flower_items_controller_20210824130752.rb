class FlowerItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @flower_items = FlowerItem.all
  end

  def show
    @flower_item = FlowerItem.find(params[:id])
    @spots = @flower_item.spots
  end
end
