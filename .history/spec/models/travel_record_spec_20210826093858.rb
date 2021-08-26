require 'rails_helper'

RSpec.describe TravelRecord, type: :model do
  context 'タイトルとクチコミが入力されている場合' do
    let!(:travel_record) do
      TravelRecord.new({ title: 'タイトル', content: 'クチコミ', place: '場所', review: "5.0")
    end
    it '投稿記事を保存できる' do
      expect(travel_record).to be_valid
    end
  end
end
