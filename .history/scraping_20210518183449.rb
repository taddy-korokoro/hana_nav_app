require 'open-uri'
require 'nokogiri'
# 取得したhtmlの文字コードをUTF-8に変換するtoutf8メソッドを使用するための設定
require 'kconv'

url = 'https://loconavi.jp/features/hananomeisho?flower=233'

# urlにアクセスしてhtmlを取得する
html = URI.open(url).read

# 取得したhtmlをNokogiriでパースする
doc = Nokogiri::HTML.parse(html)

img_src = doc.at_css('img').attribute('src')
img_url = "#{img_src}"

sleep 1
open(img_src, 'w') do |f|
  f.puts URI.open(img_url).read
end
