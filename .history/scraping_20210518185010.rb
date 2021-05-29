require 'open-uri'
require 'nokogiri'
# 取得したhtmlの文字コードをUTF-8に変換するtoutf8メソッドを使用するための設定
require 'kconv'

index = 0
flower_image = './flower_image/'

url = 'https://loconavi.jp/features/hananomeisho?flower=233'

# urlにアクセスしてhtmlを取得する
html = URI.open(url).read

# 取得したhtmlをNokogiriでパースする
doc = Nokogiri::HTML.parse(html)

target_urls = []
doc.xpath('//img').each do |node|
  # 取得した要素内のaタグのhref属性の値を配列にPushする
  node.css('a').each do |links|
    target_urls.push(links.attribute('href'))
  end
end
