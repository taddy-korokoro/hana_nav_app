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
    header = ['name', 'time', 'feature', 'image']
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
    CSV.open('db/csv_data/spot_list.csv', 'w', :force_quotes=>true) do |csv|
      # 重複したデータを取り除く
      rows = rows.uniq
      rows.each do |row|
        csv << row
      end
    end
  end
  # # DBに読み込むデータ(レコード増量版)を取得してCSVファイルへ出力(spot専用)
  # def self.spot_scrape
  #   base_url = 'https://loconavi.jp'
  #   feature_url = '/features/hananomeisho'
  #   # google mapsの正規表現、緯度・経度をキャプチャする
  #   maps_regexp = /\Ahttp:\/\/maps\.google\.com\/\?q=(.+),(.+)\z/

  #   # テーブルヘッダーの作成
  #   header = ['name', 'time', 'location', 'feature', 'image', 'url', 'latitude', 'longitude']
  #   rows = [header]

  #   # scraping
  #   html = URI.open(base_url + feature_url).read
  #   doc = Nokogiri::HTML.parse(html)

  #   # 該当IDのoptionタグのvalue値を取得するための繰り返し処理
  #   doc.css('#flower option').each {|flower|

  #     select_url_1 = URI.encode "?utf8=✓&searching=1&latitude=&longitude=&time=&flower="
  #     select_url_2 = URI.encode "&area=&keyword=&button="
  #     # 取得したvalue値を利用して絶対パスを作成
  #     html = URI.open(base_url + feature_url + select_url_1 + flower['value'] + select_url_2).read
  #     doc = Nokogiri::HTML.parse(html)

  #     # 該当クラスを2回まで繰り返し処理
  #     doc.css('.flower-spot')[0..1].each {|spot|
  #       html = URI.open(base_url + spot['href']).read
  #       doc = Nokogiri::HTML.parse(html)

  #       doc.css('.main-left-layout').each {|main|
  #         # 緯度・経度の値を取得するための処理
  #         coords = main.css('a').each{|a|
  #           c = maps_regexp.match(a[:href])
  #           break c.to_a[1..2] unless c.nil?
  #         }
  #         next if coords.nil?

  #         # 各カラムのデータを取得
  #         name = main.at_css('.block')&.inner_text
  #         time = main.css('.spot-info > .t-cell')[1]&.inner_text
  #         location = main.css('.spot-info > .t-row > .t-cell')[1]&.inner_text
  #         feature = main.at_css('.text')&.inner_text
  #         image = main.at_css('img')&.attribute('src')&.value
  #         url = main.at_css('#information p a')&.[](:href)

  #         # CSVへ追加
  #         row = [name, time, location, feature, image, url]
  #         rows << row + coords
  #       }
  #     }
  #   }
  #   # CSVに書き込み
  #   CSV.open('db/csv_data/spot_list.csv', 'w', :force_quotes=>true) do |csv|
  #     # 重複したデータを取り除く
  #     rows = rows.uniq
  #     rows.each do |row|
  #       csv << row
  #     end
  #   end
  # end

  # # DBに読み込むデータ(レコード増量版)を取得してCSVファイルへ出力(spot専用)
  # def self.spot_scrape
  #   base_url = 'https://loconavi.jp'
  #   feature_url = '/features/hananomeisho'
  #   # google mapsの正規表現、緯度・経度をキャプチャする
  #   maps_regexp = /\Ahttp:\/\/maps\.google\.com\/\?q=(.+),(.+)\z/

  #   # テーブルヘッダーの作成
  #   header = ['name', 'time', 'location', 'feature', 'image', 'url', 'latitude', 'longitude']
  #   rows = [header]

  #   50.times do |i|
  #     html = URI.open(base_url + feature_url).read
  #     doc = Nokogiri::HTML.parse(html)

  #     break if doc.css('#flower option')[i] == nil

  #     value = doc.css('#flower option')[i]['value']
  #     select_url = URI.encode "?utf8=✓&searching=1&latitude=&longitude=&time=&flower=#{value}&area=&keyword=&button="

  #     html = URI.open(base_url + feature_url + select_url).read
  #     doc = Nokogiri::HTML.parse(html)

  #     doc.css('.flower-spot')[0..3].each {|spot|
  #       html = URI.open(base_url + spot['href']).read
  #       doc = Nokogiri::HTML.parse(html)

  #       doc.css('.main-left-layout').each {|main|
  #         coords = main.css('a').each{|a|
  #           c = maps_regexp.match(a[:href])
  #           break c.to_a[1..2] unless c.nil?
  #         }
  #         next if coords.nil?

  #         # 各カラムのデータを取得
  #         name = main.at_css('.block')&.inner_text
  #         time = main.css('.spot-info > .t-cell')[1]&.inner_text
  #         location = main.css('.spot-info > .t-row > .t-cell')[1]&.inner_text
  #         feature = main.at_css('.text')&.inner_text
  #         image = main.at_css('img')&.attribute('src')&.value
  #         url = main.at_css('#information p a')&.[](:href)

  #         # 全てのデータが取得できれば CSV へ追加
  #         row = [name, time, location, feature, image, url]
  #         rows << row + coords
  #       }
  #     }
  #   end
  #   # CSVに書き込み
  #   CSV.open('db/csv_data/spot_list.csv', 'w', :force_quotes=>true) do |csv|
  #     # 重複したデータを取り除く
  #     rows = rows.uniq
  #     rows.each do |row|
  #       csv << row
  #     end
  #   end
  # end

  # DBに読み込むデータを取得してCSVファイルへ出力(spot専用)
  # def self.spot_scrape
  #   base_url = 'https://loconavi.jp'
  #   feature_url = '/features/hananomeisho'

  #   # google mapsの正規表現、緯度・経度をキャプチャする
  #   maps_regexp = /\Ahttp:\/\/maps\.google\.com\/\?q=(.+),(.+)\z/

  #   # テーブルヘッダーの作成
  #   header = ['name', 'time', 'location', 'feature', 'image', 'url', 'latitude', 'longitude']
  #   rows = [header]

  #   # scraping
  #   html = URI.open(base_url + feature_url).read
  #   doc = Nokogiri::HTML.parse(html)

  #   doc.css('.flower').each{|flower|
  #     html = URI.open(base_url + flower['href']).read
  #     doc = Nokogiri::HTML.parse(html)

  #     doc.css('.flower-spot')[0..3].each{|spot|
  #       html = URI.open(base_url + spot['href']).read
  #       doc = Nokogiri::HTML.parse(html)

  #       doc.css('.main-left-layout').each {|main|
  #         coords = main.css('a').each{|a|
  #           c = maps_regexp.match(a[:href])
  #           break c.to_a[1..2] unless c.nil?
  #         }
  #         next if coords.nil?

  #         # 各カラムのデータを取得
  #         name = main.at_css('.block')&.inner_text
  #         time = main.css('.spot-info > .t-cell')[1]&.inner_text
  #         location = main.css('.spot-info > .t-row > .t-cell')[1]&.inner_text
  #         feature = main.at_css('.text')&.inner_text
  #         image = main.at_css('img')&.attribute('src')&.value
  #         url = main.at_css('#information p a')&.[](:href)

  #         # 全てのデータが取得できれば CSV へ追加
  #         row = [name, time, location, feature, image, url]
  #         rows << row + coords if row.all?
  #       }
  #     }
  #   }
  #   # CSVに書き込み
  #   CSV.open('db/csv_data/spot_list.csv', 'w', :force_quotes=>true) do |csv|
  #     rows.each do |row|
  #       csv << row
  #     end
  #   end
  # end

  # DBに読み込むデータを取得してCSVファイルへ出力(flower_item専用)
  def self.flower_item_scrape
    base_url = 'https://loconavi.jp'
    feature_url = '/features/hananomeisho'
    url = "#{base_url}#{feature_url}"

    header = ['name', 'time', 'feature', 'image']
    rows = [header]

    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)

    # doc.css('.flower').each{|flower|
    #   row_name = []
    #   row_feature = []

    #   time = flower.at_css('.time').inner_text
    #   image = flower.at_css('img').attribute('src')
    #   row_time = [time]
    #   row_image = [image]

    #   html = URI.open(base_url + flower['href']).read
    #   doc = Nokogiri::HTML.parse(html)

    #   doc.css('.flower-description').each {|node|
    #     name = node.at_css('h1').inner_text.delete("の名所・見頃情報")
    #     feature = node.at_css('.text')&.inner_text
    #     row_name = [name]
    #     row_feature = [feature]
    #   }
    #   rows << row_name + row_time + row_feature + row_image
    # }
    doc.css('#flower option').each {|flower|
      # 絶対パスを作成するために必要なパスを変数に格納
      select_url_1 = URI.encode "?utf8=✓&searching=1&latitude=&longitude=&time=&flower="
      select_url_2 = URI.encode "&area=&keyword=&button="
      # 取得したvalue値を利用して絶対パスを作成
      html = URI.open(base_url + feature_url + select_url_1 + flower['value'] + select_url_2).read
      doc = Nokogiri::HTML.parse(html)

      doc.css('.flower-description').each{|main|
        name = main.at_css('h1')&.inner_text.delete("の名所・見頃情報")
        time = "月旬〜月旬"
        feature = main.at_css('p')&.inner_text
        image = main.at_css('img')&.attribute('src')&.value

        row = []

        if name.present? && image.present?
          row = [name, time, feature, image]
        end
        byebug
        rows << row
      }
    }
    CSV.open('db/csv_data/flower_item.csv', 'w', :force_quotes=>true) do |csv|
      rows = rows
      rows.each do |row|
        csv << row
      end
    end
  end
end