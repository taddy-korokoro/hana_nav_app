class Scraping < ApplicationRecord
  require 'mechanize'

    def self.flower_item_scrape
      agent = Mechanize.new
      page = agent.get("https://loconavi.jp/features/hananomeisho")
      names = page.search('.name')
      features = page.search('.description').inner_text
      images = page.at('.flower-image img')[:src]
      p names
      # folwer_items = FlowerItem.new
      # folwer_items.name = names
      # folwer_items.feature = features
      # folwer_items.image = images
      # folwer_items.save
    end
  end