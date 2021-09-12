### 全国にある花の名所を探すことができる共有サイト「花ナビ(hana_nav)」

[![Image from Gyazo](https://i.gyazo.com/500ce9a9a11dc63b9cfe58778b94d451.png)](https://gyazo.com/500ce9a9a11dc63b9cfe58778b94d451)

## サービス概要
「今住んでいる付近で花を楽しみたい！でも周りにどのようなスポットがあるのか分からない、、」<br>
こんな悩みを解決したい方の手助けになると思い作成しました。

## サービスURL

heroku: https://hana-nav.herokuapp.com (レスポンス未対応)

## 環境

- ruby 2.7.2
- rails 6.1.4
  - Slim(HTMLテンプレートエンジン)
  - Bootstrap4(WEBフレームワーク)
  - BEM(CSS設計) 
- MySQL
- heroku(AWS:S3)

## 機能一覧

- 新規登録/ログイン/パスワード再設定機能(devise)
- 検索機能(ransack)
  - スポット検索 
  - ユーザー検索(ソート機能)
- 投稿機能
　　　　-　画像投稿(carrierwave,rmagick,fog-aws)
　　　　 -　プレビュー機能
　　　　-　インクリメンタルサーチ機能(タイムレス検索)
　　　　-　レビュー機能(raty)
- タイムライン機能
  - フォローユーザーの投稿を確認できる
- お気に入り機能(Ajax)
  -　スポットの登録
- いいね機能(Ajax)
  -　ユーザーの投稿に対して共感等の意思表現 
- フォロー機能(Ajax)
- ページネーション機能(kaminari)
- スポット所在地の地図表示(google maps API)

## スポットデータの取得
- スクレイピング(nokogiri)->(app/models/scraping.rb)
- バルクインサート(activerecord-import)
  - CSVファイルのデータをDBに投入

## テスト
- RSpec
