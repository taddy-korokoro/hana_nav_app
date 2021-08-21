class Scraping < ApplicationRecord
  require 'open-uri'
  require 'nokogiri'
  require 'csv'

  # DBに読み込むデータ(レコード増量版)を取得してCSVファイルへ出力(spot専用)
  def self.spot_scrape
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

    # 該当IDのoptionタグのvalue値を取得するための繰り返し処理
    doc.css('#flower option').each {|flower|

      select_url_1 = URI.encode "?utf8=✓&searching=1&latitude=&longitude=&time=&flower="
      select_url_2 = URI.encode "&area=&keyword=&button="
      # 取得したvalue値を利用して絶対パスを作成
      html = URI.open(base_url + feature_url + select_url_1 + flower['value'] + select_url_2).read
      doc = Nokogiri::HTML.parse(html)

      # 該当クラスを2回まで繰り返し処理
      doc.css('.flower-spot')[0..1].each {|spot|
        html = URI.open(base_url + spot['href']).read
        doc = Nokogiri::HTML.parse(html)

        doc.css('.main-left-layout').each {|main|
          # 緯度・経度の値を取得するための処理
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

          # CSVへ追加
          row = [name, time, location, feature, image, url]
          rows << row + coords
        }
      }
    }
    # CSVに書き込み
    CSV.open('db/csv_data/spot.csv', 'w', :force_quotes=>true) do |csv|
      # 重複したデータを取り除く
      rows = rows.uniq
      rows.each do |row|
        csv << row
      end
    end
  end

  # DBに読み込むデータを取得してCSVファイルへ出力(flower_item専用)
  def self.flower_item_scrape
    base_url = 'https://loconavi.jp'
    feature_url = '/features/hananomeisho'

    header = ['name', 'time', 'feature', 'image']
    rows = [header]

    html = URI.open(base_url + feature_url).read
    doc = Nokogiri::HTML.parse(html)

    doc.css('#flower option').each {|flower|
      # 絶対パスを作成するために必要なパスを変数に格納
      select_url_1 = URI.encode "?utf8=✓&searching=1&latitude=&longitude=&time=&flower="
      select_url_2 = URI.encode "&area=&keyword=&button="
      # 取得したvalue値を利用して絶対パスを作成
      html = URI.open(base_url + feature_url + select_url_1 + flower['value'] + select_url_2).read
      doc = Nokogiri::HTML.parse(html)

      doc.css('.flower-description').each{|main|
        name = main.at_css('h1')&.inner_text.delete("の名所・見頃情報")
        time = "月〜月"
        feature = main.at_css('p')&.inner_text
        image = main.at_css('img')&.attribute('src')&.value

        row = [name, time, feature, image]
        rows << row if image.present?
      }
    }
    CSV.open('db/csv_data/flower_item.csv', 'w', :force_quotes=>true) do |csv|
      rows.each do |row|
        csv << row
      end
    end
  end
end