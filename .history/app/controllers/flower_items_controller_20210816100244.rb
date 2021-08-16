class FlowerItemsController < ApplicationController
  before_action :set_flower_item, only: [:edit, :show, :update, :destory]

  def index
    @flower_items = FlowerItem.all
  end

  def show
    @flower_item = FlowerItem.find(params[:id])
    @spots = @flower_item.spots
  end
end
