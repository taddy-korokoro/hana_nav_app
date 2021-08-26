require 'rails_helper'

RSpec.describe TravelRecord, type: :model do
  before do
    @travel_record = build(:travel_record)
  end

  describe "バリデーション" do
    it "全てのカラムに値が正しく設定されている状態" do
      # @travel_record.visited_on = "2021/08/26"
      expect(@travel_record.valid?).to eq(true)
    end
    it "contentが空だとNG" do
      @travel_record.content = ""
      expect(@travel_record.valid?).to eq(false)
    end
  end
end
