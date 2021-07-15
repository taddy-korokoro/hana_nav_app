class FlowerItem < ApplicationRecord
	has_many :flower_item_spots
  has_many :spots, through: :flower_item_spots
  belongs_to :season, optional: true

  require 'open-uri'
  require 'nokogiri'

  url = 'https://loconavi.jp/features/hananomeisho'
  sleep 1

  html = URI.open(url).read
  doc = Nokogiri::HTML.parse(html)

  doc.css('.flower-list').each do | n |
    FlowerItem.create!(
      name: n.at_css('.name').inner_text,
      time: n.at_css('.time').inner_text,
      feature: n.at_css('.description').inner_text,
      image: n.at_css('img').attribute('href')
    )
  end
end