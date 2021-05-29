class Scraping < ApplicationRecord
  require 'mechanize'

    def self.flower_item_scrape
      agent = Mechanize.new
      page = agent.get("https://loconavi.jp/features/hananomeisho")
      names = page.search('.name')
      features = page.search('.description')
      # images = page.at('.flower-image img')[:src]

      FlowerItem.transaction do
        names.each_with_index do |name, index|
          FlowerItem.create!(name: name.inner_text, feature: features[index].inner_text)
        end
      end
    end
  end