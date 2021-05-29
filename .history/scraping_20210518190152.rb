# ------------------------------------------------
# 初期処理
# ------------------------------------------------
# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

index = 0
# 画像ファイルの保存先
download_key = './download_imgs/'

# ------------------------------------------------
# 一覧画面から、詳細画面へのURLを取得する処理
# ------------------------------------------------

# 一覧画面のHTMLを読み込んでNokogiriでparseする
index_url = 'https://game8.jp/splatoon-2/158447'
charset = nil
index_html = open(index_url) do |f|
  charset = f.charset
  f.read
end
index_doc = Nokogiri::HTML.parse(index_html, nil, charset)

# 特定のタグ・クラスの要素を取得して、取得数分処理を繰り返す
target_urls = []
index_doc.xpath('//table[@class="a-table a-table a-table "]').each do |node|
  # 取得した要素内のaタグのhref属性の値を配列にPushする
  node.css('a').each do |links|
    target_urls.push(links.attribute('href'))
  end
end

# ------------------------------------------------
# 取得した詳細画面URLから画像をダウンロードする
# ------------------------------------------------
target_urls.each do |url|
  
  # 一覧画面のHTMLを読み込んでNokogiriでparseする
  charset = nil
  html = open(url) do |f|
    charset = f.charset # 文字種別を取得
    f.read # htmlを読み込んで変数htmlに渡す
  end
  doc = Nokogiri::HTML.parse(html, nil, charset)

  # 特定の画像を抜き取るためにタグ・クラスを指定して目的の値を取得する
  img_urls = []
  doc.xpath('//div[@class="l-3colMain__center l-3colMain__center--shadow"]').each do |node1|
    node1.xpath('//div[@class="archive-style-wrapper"]').each do |node2|
      node2.xpath('//p[@class="a-paragraph"]').each do |node3|
        # imgタグのsrc属性から画像のURLを取得する
        unless node3.css('img').attribute('src').nil?
          img_urls.push(node3.css('img').attribute('src').value)
        end
      end
    end
  end

  # 取得した画像URLから画像をダウンロードする
  img_urls.each do |img_url|
    File.open(download_key + index.to_s + '.png','w+b') do |out|
      open(img_url) do |data|
        out.write(data.read)
      end
      index = index + 1
    end
  end

end
