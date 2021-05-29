require 'open-uri'
require 'nokogiri'
# 取得したhtmlの文字コードをUTF-8に変換するtoutf8メソッドを使用するための設定
require 'kconv'

url = 'https://www.yahoo.co.jp/'

# urlにアクセスしてhtmlを取得する
html = URI.open(url).read.toutf8

# 取得したhtmlをNokogiriでパースする
doc = Nokogiri::HTML.parse(html)

# ニュースの見出しを取得して出力する
doc.at_css('section#tabpanelTopics1 ul').css('h1').each do |h1|
  puts h1.text.strip
end