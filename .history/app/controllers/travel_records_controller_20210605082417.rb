class TravelRecordsController < ApplicationController
  def index
    @travel_records = TravelRecord.all
  end
end
