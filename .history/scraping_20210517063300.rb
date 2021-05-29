require 'open-uri'
require 'nokogiri'

url = 'https://www.yahoo.co.jp/'

# urlにアクセスしてhtmlを取得する
html = URI.open(url).read

# 取得したhtmlをNokogiriでパースする
doc = Nokogiri::HTML.parse(html)

# htmlのtitleを取得して出力する
title = doc.title
puts title

# 取得されたメタ情報のうちContent-Typeとcharsetを確認する
URI.open(url) {|f|
  p f.content_type
  p f.charset
}

puts html