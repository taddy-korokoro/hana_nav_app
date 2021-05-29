require 'open-uri'
require 'nokogiri'
# 取得したhtmlの文字コードをUTF-8に変換するtoutf8メソッドを使用するための設定
require 'kconv'

url = 'https://loconavi.jp/features/hananomeisho'

html = URI.open(url).read
puts html
