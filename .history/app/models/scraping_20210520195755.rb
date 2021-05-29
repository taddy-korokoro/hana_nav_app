class Scraping < ApplicationRecord
require 'mechanize'

  def self.flower_item_scrape
    agent = Mechanize.new
    page = agent.get("https://loconavi.jp/features/hananomeisho")
    name = page.search('.name').inner_text if page.search('.name')
    feature = page.search('.description').inner_text if page.search('.description')
    image = page.search('.flower-image img')[:src] if page.search('.flower-image img')

    folwer_items = FlowerItem.new
    folwer_items.name = name
    folwer_items.feature = feature
    folwer_items.image = image

    folwer_items.save
  end
end
