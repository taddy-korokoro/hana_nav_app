class Scraping < ApplicationRecord
require 'mechanize'

  def self.flower_item_scrape
    agent = Mechanize.new
    page = agent.get("https://loconavi.jp/features/hananomeisho")
    names = page.search('.name').inner_text if page.search('.name')
    features = page.search('.description').inner_text if page.search('.description')

    FlowerItem.transaction do
      names.each_with_index do |name, index|
        FlowerItem.create!(name: name, feature: features[index])
      end
    end
  end
end
