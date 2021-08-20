class Scraping < ApplicationRecord
  require 'open-uri'
  require 'nokogiri'
  require 'csv'

  # DBに読み込むデータを取得してCSVファイルへ出力(spot専用)
  def self.spot_list_scrape
    base_url = 'https://loconavi.jp'
    feature_url = '/features/hananomeisho'

    # google mapsの正規表現、緯度・経度をキャプチャする
    maps_regexp = /\Ahttp:\/\/maps\.google\.com\/\?q=(.+),(.+)\z/

    # テーブルヘッダーの作成
    header = ['name', 'time', 'location', 'feature', 'image', 'url', 'latitude', 'longitude']
    rows = [header]

    # scraping
    html = URI.open(base_url + feature_url).read
    doc = Nokogiri::HTML.parse(html)

    doc.css('.flower').each{|flower|
      html = URI.open(base_url + flower['href']).read
      doc = Nokogiri::HTML.parse(html)

      doc.css('.flower-spot')[0..3].each{|spot|
        html = URI.open(base_url + spot['href']).read
        doc = Nokogiri::HTML.parse(html)

        doc.css('.main-left-layout').each {|main|
          coords = main.css('a').each{|a|
            c = maps_regexp.match(a[:href])
            break c.to_a[1..2] unless c.nil?
          }
          next if coords.nil?

          # 各カラムのデータを取得
          name = main.at_css('.block')&.inner_text
          time = main.css('.spot-info > .t-cell')[1]&.inner_text
          location = main.css('.spot-info > .t-row > .t-cell')[1]&.inner_text
          feature = main.at_css('.text')&.inner_text
          image = main.at_css('img')&.attribute('src')&.value
          url = main.at_css('#information p a')&.[](:href)

          # 全てのデータが取得できれば CSV へ追加
          row = [name, time, location, feature, image, url]
          rows << row + coords if row.all?
        }
      }
    }
    # CSVに書き込み
    CSV.open('db/csv_data/spot_list.csv', 'w', :force_quotes=>true) do |csv|
      rows.each do |row|
        csv << row
      end
    end
  end

  # DBに読み込むデータを取得してCSVファイルへ出力(flower_item専用)
  def self.flower_item_scrape
    base_url = 'https://loconavi.jp'
    feature_url = '/features/hananomeisho'
    url = "#{base_url}#{feature_url}"

    header = ['name', 'time', 'feature', 'image']
    rows = []
    rows << header

    20.times do |i|
      html = URI.open(url).read
      doc = Nokogiri::HTML.parse(html)

      if doc.css('.flower')[i] == nil
        break
      end
      time = doc.css('.time')[i].inner_text
      feature = doc.css('.description')[i].inner_text
      image = doc.css('img').attribute('src')[i]
      byebug
      row_1 = [time, feature, image]

      flower_href = doc.css('.flower')[i]["href"]
      next_url = "#{base_url}#{flower_href}"

      html = URI.open(next_url).read
      doc = Nokogiri::HTML.parse(html)

      doc.css('.flower-description').each do |node|
        name = node.at_css('h1').inner_text.delete("の名所・見頃情報")

        row = [name]
        rows << row + row_1
      end
    end
    CSV.open('db/csv_data/re_flower_item_list.csv', 'w', :force_quotes=>true) do |csv|
      rows.each do |row|
        csv << row
      end
    end
  end

  # def self.flower_item_scrape
  #   url = 'https://loconavi.jp/features/hananomeisho'
  #   html = URI.open(url).read

  #   header = ['name', 'time', 'feature', 'image']
  #   rows = []
  #   rows << header

  #   doc = Nokogiri::HTML.parse(html)

  #   doc.css('.flower').each do | node |
  #     name = node.at_css('.name').inner_text.delete("の名所" "お花見" "まつり" "・")
  #     time = node.at_css('.time').inner_text
  #     feature = node.at_css('.description').inner_text
  #     image = node.at_css('img').attribute('src').value

  #     rows << [name, time, feature, image]
  #   end
  #   CSV.open('flower_item_list.csv', 'w', :force_quotes=>true) do |csv|
  #     rows.each do |row|
  #       csv << row
  #     end
  #   end
  # end
end