class Scraping < ApplicationRecord
require 'mechanize'

  def self.flower_item_scrape
    agent = Mechanize.new
    page = agent.get("https://loconavi.jp/features/hananomeisho")
    name = page.search('.name').inner_text if page.search('.name')
    feature = page.search('.description').inner_text if page.search('.description')

    folwer_item = FlowerItem.new
    folwer_item.name = name
    folwer_item.feature = feature
    folwer_item.save
  end
end
