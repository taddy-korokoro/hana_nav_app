require 'open-uri'
require 'nokogiri'
# 取得したhtmlの文字コードをUTF-8に変換するtoutf8メソッドを使用するための設定
require 'kconv'

base_url = 'https://arao99.github.io/zenn_scraping/'
url = "#{base_url}priest_spell_level1.html"

loop do
  sleep 1
  html = URI.open(url).read
  doc = Nokogiri::HTML.parse(html)
  doc.css('.spell').each do |spell|
    puts spell.text.strip
  end
  next_link = doc.at_css('a[rel="next"]')
  break unless next_link
  next_href = next_link.attribute('href')
  url = "#{base_url}#{next_href}"
end