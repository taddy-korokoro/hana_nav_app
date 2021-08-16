class FlowerItemsController < ApplicationController
  before_action :set_flower_item, only: [:edit, :show, :update, :destory]

  def index
    @flower_items = FlowerItem.all
  end

  def new
    @flower_item = FlowerItem.new
  end

  def create
    @flower_item = FlowerItem.new(flower_item_params)
    if @flower_item.save
      redirect_to flower_item_path(@flower_item.id)
    else
      render :new
    end
  end

  def show
    @flower_item = FlowerItem.find(params[:id])
    @spots = @flower_item.spots
  end

  def update
    @flower_item.update(flower_item_params)
    if @flower_item.save
      redirect_to flower_item_path(@flower_item.id)
    else
      render :edit
    end
  end

  def destory
    @flower_item.destory
    redirect_to flower_items_path
  end

  private
    def flower_item_params
      params.require(:flower_item).permit(:name, :time, :feature,
                  :image, :image_cache, :remove_image, :season_id)
    end

    def set_flower_item
      @flower_item = FlowerItem.find(params[:id])
    end
end
