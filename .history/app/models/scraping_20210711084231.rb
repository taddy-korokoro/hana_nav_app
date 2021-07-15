require 'open-uri'
require 'nokogiri'
def self.flower_item_scrape
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
end