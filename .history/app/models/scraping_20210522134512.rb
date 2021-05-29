class Scraping < ApplicationRecord
  require 'mechanize'
  
    def self.flower_item_scrape
      agent = Mechanize.new
      page = agent.get("https://loconavi.jp/features/hananomeisho")
      name = page.at('.name').inner_text if page.at('.name')
      feature = page.at('.description').inner_text if page.at('.description')
      image = page.at('.flower-image img')[:src] if page.at('.flower-image img')
  
      folwer_items = FlowerItem.new
      folwer_items.name = name
      folwer_items.feature = feature
      folwer_items.image = image
  
      folwer_items.save
    end
  end