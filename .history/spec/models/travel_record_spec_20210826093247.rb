require 'rails_helper'

RSpec.describe TravelRecod, type: :model do
  context 'タイトルとクチコミが入力されている場合' do
    let!(:travel_record) do
      TravelRecod.new({ title: 'タイトル', content: 'クチコミ'})
    end
    it '投稿記事を保存できる' do
      expect(travel_record).to be_valid
    end
  end
end
