class Scraping < ApplicationRecord
require 'mechanize'

  def self.flower_item_scrape
    agent = Mechanize.new
    page = agent.get("https://loconavi.jp/features/hananomeisho")
    names = page.search('.name').inner_text if page.search('.name')
    features = page.search('.description').inner_text if page.search('.description')

    folwer_item = FlowerItem.new

    names.each do |name|
      folwer_item.name = name
    end

    features.each do |feature|
      folwer_item.feature = feature
    end

    folwer_item.save
  end
end
