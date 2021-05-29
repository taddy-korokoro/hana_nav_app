require 'open-uri'
require 'nokogiri'

url = 'https://loconavi.jp/features/hananomeisho'

html = URI.open(url).read
doc = Nokogiri::HTML.parse(html)
img_src = doc.at_css('img').attribute('src')
img_url = 'https://image-loconavi.tokubai.co.jp/h=200,w=200,a=2/uploads/hananomeisho/flower/image/10/9afccc4b-6929-42ed-8375-785ffd3ddeeb.jpg'

sleep1
open(img_src, 'w') do |f|
  f.puts URI.open(img_url).read
end