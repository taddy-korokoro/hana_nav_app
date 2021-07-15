require 'open-uri'
require 'nokogiri'

url = 'https://www.yahoo.co.jp/'

# 取得されたメタ情報のうちContent-Typeとcharsetを確認する
URI.open(url) {|f|
  p f.content_type
  p f.charset
}