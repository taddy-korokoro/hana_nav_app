require 'open-uri'
require 'nokogiri'
# 取得したhtmlの文字コードをUTF-8に変換するtoutf8メソッドを使用するための設定
require 'kconv'

url = 'https://arao99.github.io/zenn_scraping/nokogiri_practice.html'

html = URI.open(url).read
doc = Nokogiri::HTML.parse(html)
title = doc.title
puts title
pp Time.now # 現在時刻を出力

sleep 1 # 1秒スリープ

html = URI.open(url).read
doc = Nokogiri::HTML.parse(html)
title = doc.title
puts title
pp Time.now

sleep rand(1.5..3.0) # 1.5〜3.0秒のランダムスリープ

html = URI.open(url).read
doc = Nokogiri::HTML.parse(html)
title = doc.title
puts title
pp Time.now