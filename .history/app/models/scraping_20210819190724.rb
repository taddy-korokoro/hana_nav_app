class Scraping < ApplicationRecord
  require 'open-uri'
  require 'nokogiri'
  require 'csv'

  def self.flower_item_rename
    table = CSV.table('db/csv_data/rename.csv') #CSVファイルをテーブルに読み込む
    table[:name] = table[:name].map! {|x| [x + '改']}
    p table.headers #ヘッダー部を出力
    p table[0] #データ部を出力
    File.write('db/csv_data/sin_rename.csv', table)
  end


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

  # DBに直接データ保存(spot専用)
  # def self.spot_scrape
  #   base_url = 'https://loconavi.jp/'
  #   feature_url = 'features/hananomeisho'
  #   url = "#{base_url}#{feature_url}"
  #   # google mapsの正規表現、緯度経度をキャプチャする
  #   maps_regexp = /\Ahttp:\/\/maps\.google\.com\/\?q=(.+),(.+)\z/

  #   20.times do |i|
  #     html = URI.open(url).read
  #     doc = Nokogiri::HTML.parse(html)

  #     if doc.css('.flower')[i] == nil
  #       break
  #     end

  #     flower_href = doc.css('.flower')[i]["href"]
  #     next_url = "#{base_url}#{flower_href}"

  #     3.times do |i|
  #       html = URI.open(next_url).read
  #       doc = Nokogiri::HTML.parse(html)

  #       # 取得したいスポットがない場合、次のループに移行
  #       if doc.css('.flower-spot')[i] == nil
  #         next
  #       end
  #       # href属性値の取得(相対URL)。また、_[i]_はtimesメソッドの変数で、繰り返すことに1づつ数値が増えていく
  #       href = doc.css('.flower-spot')[i]["href"]
  #       # 相対URLから絶対URLを作成
  #       link_url = "#{base_url}#{href}"

  #       html = URI.open(link_url).read
  #       doc = Nokogiri::HTML.parse(html)

  #       doc.css('.main-left-layout').each do | node |
  #         sleep 0.5

  #         latitude, longitude = nil, nil
  #         node.css("a").each do |node|
  #           # aタグを絞り込み正規表現にマッチするリンクを探す
  #           result = maps_regexp.match(node[:href])
  #           # アンマッチの場合はnilなので次の要素へ
  #           next if result.nil?
  #           # match:マッチ全体 latitude:緯度 longitude:経度
  #           match, latitude, longitude = result.to_a
  #         end

  #         # データが取得できなかった場合、次のループに移行
  #         if node.at_css('.block') == nil \
  #           || node.css('.spot-info > .t-cell')[1] == nil \
  #           || node.css('.spot-info > .t-row > .t-cell')[1] == nil \
  #           || node.at_css('.text') == nil \
  #           || node.at_css('img') == nil \
  #           || node.at_css('#information p a') == nil
  #           next
  #         end

  #         # DBに取得したデータを保存
  #         Spot.create!(
  #           name: node.at_css('.block').inner_text,
  #           time: node.css('.spot-info > .t-cell')[1].inner_text,
  #           location: node.css('.spot-info > .t-row > .t-cell')[1].inner_text,
  #           feature: node.at_css('.text').inner_text,
  #           image: node.at_css('img').attribute('src'),
  #           url: node.at_css('#information p a')["href"],
  #           latitude: latitude,
  #           longitude: longitude
  #         )
  #       end
  #     end
  #   end
  # end

  # DBに読み込むデータを取得してCSVファイルへ出力(flower_item専用)
  def self.flower_item_scrape
    url = 'https://loconavi.jp/features/hananomeisho'
    html = URI.open(url).read

    header = ['name', 'time', 'feature', 'image']
    rows = []
    rows << header

    doc = Nokogiri::HTML.parse(html)

    doc.css('.flower').each do | node |
      name = node.at_css('.name').inner_text.delete("の名所" "お花見" "まつり" "・")
      time = node.at_css('.time').inner_text
      feature = node.at_css('.description').inner_text
      image = node.at_css('img').attribute('src').value

      rows << [name, time, feature, image]
    end

    CSV.open('flower_item_list.csv', 'w', :force_quotes=>true) do |csv|
      rows.each do |row|
        csv << row
      end
    end
  end

  # DBに直接データ保存(flower_item専用)
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
end