class ImageUploader < CarrierWave::Uploader::Base
include CarrierWave::RMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
end