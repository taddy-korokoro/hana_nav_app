require 'open-uri'
require 'nokogiri'

class FlowerItem < ApplicationRecord
end

url = 'https://loconavi.jp/features/hananomeisho'

sleep 1

html = URI.open(url).read

doc = Nokogiri::HTML.parse(html)

doc.css('.flower-list').each do | node |
  FlowerItem.create!(
    name: node.at_css('.name').inner_text,
    feature: node.at_css('.description').inner_text,
    image: node.at_css('.flower-image > img').attribute('href'),
    season: node.at_css('.time').inner_text
  )
end