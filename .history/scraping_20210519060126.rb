require 'open-uri'
require 'nokogiri'

base_url = 'https://arao99.github.io/zenn_scraping/'

html = URI.open("#{base_url}wiz_report.html").read
doc = Nokogiri::HTML.parse(html)
img_src = doc.at_css('img').attribute('src')
img_url = "#{base_url}#{img_src}"

sleep 1

puts img_src.text