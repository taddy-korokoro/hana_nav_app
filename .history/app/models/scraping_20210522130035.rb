class Scraping < ApplicationRecord
require 'mechanize'

  def self.flower_item_scrape
    agent = Mechanize.new
    page = agent.get("https://loconavi.jp/features/hananomeisho")
    names = page.search('.name').inner_text
    features = page.search('.description').inner_text

    FlowerItem.transaction do
      names.each_line do |name, index|
        FlowerItem.create!(name: name, feature: features[index])
      end
    end
  end
end
