class Scraping < ApplicationRecord
require 'mechanize'

  def self.flower_item_scrape
    agent = Mechanize.new
    page = agent.get("https://loconavi.jp/features/hananomeisho")
    names = page.search('.name').inner_text
    features = page.search('.description').inner_text
    image = page.search('.flower-image img').get_attribute('src')

    FlowerItem.transaction do
      names.each_with_index do |name, index|
        FlowerItem.create!(name: name, feature: features[index], image: images[index])
      end
    end
  end
end
