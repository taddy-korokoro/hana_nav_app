require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['S3_REGION'],
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY']
    }
    config.fog_directory     =  'hana-nav-img'
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  end

  # 日本語ファイル名の設定
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
end

# CarrierWave.configure do |config|
# # 環境によって画像の保存場所を変更する設定
#   if Rails.env.production?
#     config.storage :fog
#     config.fog_provider = 'fog/aws'
#     config.fog_directory  = 'hana-nav-img'
#     config.fog_credentials = {
#       provider: 'AWS',
#       aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
#       aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
#       region: ENV['AWS_REGION'],
#       path_style: true
#     }
#   else
#     config.storage :file
#     config.enable_processing = false if Rails.env.test?
#   end
# end

# # ファイル名に日本語を許可
# CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/