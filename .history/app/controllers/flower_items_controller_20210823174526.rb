class FlowerItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @flower_items = FlowerItem.all
    respond_to do |format|
      format.html do
      end
      format.csv do
        send_data render_to_string, filename: "flower_items.csv", type: :csv
      end
    end
  end

  def show
    @flower_item = FlowerItem.find(params[:id])
    @spots = @flower_item.spots
  end
end
