class FlowerItem < ApplicationRecord
	has_many :flower_item_spots
  has_many :spots, through: :flower_item_spots
  belongs_to :season, optional: true

  require 'open-uri'
  require 'nokogiri'

  url = 'https://loconavi.jp/features/hananomeisho'

  html = URI.open(url).read
  doc = Nokogiri::HTML.parse(html)

  doc.css('.flower').each do | node |
    FlowerItem.create!(
      sleep 1
      name: node.at_css('.name').inner_text,
      time: node.at_css('.time').inner_text,
      feature: node.at_css('.description').inner_text,
      image: node.at_css('img').attribute('src')
    )
  end
end