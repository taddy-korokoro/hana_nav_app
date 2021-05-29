class Scraping < ApplicationRecord
require 'mechanize'

  def self.flower_item_scrape
    agent = Mechanize.new
    page = agent.get("https://loconavi.jp/features/hananomeisho")
    names = page.search('.name').inner_text if page.search('.name')
    features = page.search('.description').inner_text if page.search('.description')

    folwer_item = FlowerItem.new

    names.each do |na|
      folwer_item.name = na
    end

    features.each do |featu|
      folwer_item.feature = featu
    end

    folwer_item.save
  end
end
