include CarrierWave::RMagick

  if Rails.env.production?
    storage :fog　　　　　　　　# 本番時にS3にファイルを保存する
  else
    storage :file             # 開発・テスト時にはローカルにファイルを保存する
  end