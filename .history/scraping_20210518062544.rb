require 'open-uri'
require 'nokogiri'
# 取得したhtmlの文字コードをUTF-8に変換するtoutf8メソッドを使用するための設定
require 'kconv'

url = 'https://loconavi.jp/features/hananomeisho'

# urlにアクセスしてhtmlを取得する
html = URI.open(url).read

# 取得したhtmlをNokogiriでパースする
doc = Nokogiri::HTML.parse(html)

doc.at_css('div.flower-body').css('time').each do |h1|
  puts h1.text.strip
end
