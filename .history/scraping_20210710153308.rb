require 'open-uri'
require 'nokogiri'

url = 'https://www.yahoo.co.jp/'

# urlにアクセスしてhtmlを取得する
html = URI.open(url).read

# 取得したhtmlをNokogiriでパースする
doc = Nokogiri::HTML.parse(html)

pp doc.at_css('h1').text(2)