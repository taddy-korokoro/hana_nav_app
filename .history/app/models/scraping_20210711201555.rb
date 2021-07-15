class Scraping < ApplicationRecord
  require 'open-uri'
  require 'nokogiri'

  def self.spot_scrape
    base_url = 'https://loconavi.jp/features/hananomeisho'
    url = "#{base_url}?flower=229"
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)
    doc.css('.flower-spot').each do | node |
      sleep 1
      Spot.create!(
        name: node.at_css('.name').inner_text,
        location: node.at_css('.address').inner_text,
        feature: node.at_css('.description').inner_text,
        image: node.at_css('img').attribute('src')
      )
    end
  end

  def self.flower_item_scrape
    url = 'https://loconavi.jp/features/hananomeisho'
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)
    doc.css('.flower').each do | node |
      sleep 1
      FlowerItem.create!(
        name: node.at_css('.name').inner_text.delete("の名所" "お花見" "まつり" "・"),
        time: node.at_css('.time').inner_text,
        feature: node.at_css('.description').inner_text,
        image: node.at_css('img').attribute('src')
      )
    end
  end




  # Mechanizeでのスクレイピング

  # require 'mechanize'
  # require 'nokogiri'
  # # スポットデータを取得してDBに保存
  # def self.spot_scrape
  #   agent = Mechanize.new
  #   page = agent.get()
  # end

  # def self.flower_item_scrape
  #   agent = Mechanize.new
  #   base_url = 'https://loconavi.jp'
  #   page = agent.get("#{base_url}/features/hananomeisho")
  #   # 取得したいページへ遷移
  #   page = agent.page.link_with(:dom_class => "flower").click

  #   names = page.search('.flower-description h1')
  #   features = page.search('.text p')
  #   images = page.images_with(:src => /jpg\Z/)

  #   FlowerItem.transaction do
  #     names.each_with_index do |name, index|
  #       FlowerItem.create!(name: name.inner_text, feature: features[index].inner_text, image: images[index])
  #     end
  #   end
  # end
end