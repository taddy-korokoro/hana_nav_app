class Scraping < ApplicationRecord
require 'mechanize'

  def self.flower_item_scrape
    agent = Mechanize.new
    page = agent.get("https://loconavi.jp/features/hananomeisho")
    names = page.at('.name').inner_text if page.at('.name')
    features = page.at('.description').inner_text if page.at('.description')
    images = page.at('.flower-image img')[:src] if page.at('.flower-image img')

    FlowerItem.transaction do
      names.each_with_index do |name, index|
        FlowerItem.create!(name: name, feature: features[index], image: images[index])
      end
    end
    # folwer_items = FlowerItem.new
    # folwer_items.name = name
    # folwer_items.feature = feature
    # folwer_items.image = image

    # folwer_items.save
  end
end
