class Scraping < ApplicationRecord
  require 'open-uri'
  require 'nokogiri'

  def self.spot_scrape
    base_url = 'https://loconavi.jp/'
    features_url = 'features/hananomeisho'
    url = "#{base_url}#{features_url}"

    20.times do |i|
      html = URI.open(url).read
      doc = Nokogiri::HTML.parse(html)

      if doc.css('.flower')[i] == nil
        break
      end

      flower_href = doc.css('.flower')[i]["href"]
      next_url = "#{base_url}#{flower_href}"

      3.times do |i|
        html = URI.open(next_url).read
        doc = Nokogiri::HTML.parse(html)

        # 取得したいスポットがない場合、次のループに移行
        if doc.css('.flower-spot')[i] == nil
          next
        end
        # href属性値の取得(相対URL)。また、_[i]_はtimesメソッドの変数で、繰り返すことに1づつ数値が増えていく
        href = doc.css('.flower-spot')[i]["href"]
        # 相対URLから絶対URLを作成
        link_url = "#{base_url}#{href}"

        html = URI.open(link_url).read
        doc = Nokogiri::HTML.parse(html)

        doc.css('.main-left-layout').each do | node |
          sleep 0.5

          # データが取得できなかった場合、次のループに移行
          if node.at_css('.block') == nil \
            || node.css('.spot-info > .t-cell')[1] == nil \
            || node.css('.spot-info > .t-row > .t-cell')[1] == nil \
            || node.at_css('.text') == nil \
            || node.at_css('img') == nil \
            || node.at_css('#information p a') == nil
            next
          end

          # DBに取得したデータを保存
          Spot.create!(
            name: node.at_css('.block').inner_text,
            time: node.css('.spot-info > .t-cell')[1].inner_text,
            location: node.css('.spot-info > .t-row > .t-cell')[1].inner_text,
            feature: node.at_css('.text').inner_text,
            image: node.at_css('img').attribute('src'),
            url: node.at_css('#information p a')["href"],
            latitude: node.at_css('#information p > a')[1]["href"].to_str,
            longitude: node.at_css('#information p a')["href"]
          )
        end
      end
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