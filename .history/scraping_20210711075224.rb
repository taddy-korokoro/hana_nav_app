require 'open-uri'
require 'nokogiri'

url = 'https://loconavi.jp/features/hananomeisho'

charset = nil
sleep 1
html = open(url).read
end

doc = Nokogiri::HTML.parse(html, nil, charset)

doc.css('.flower-list').each do | node |
  FlowerItem.create(
    name: node.at_css('.name').inner_text,
    feature: node.at_css('.description').inner_text,
    image: node.at_css('.flower-image > img').attribute('href'),
    season: node.at_css('.time').inner_text
  )
end