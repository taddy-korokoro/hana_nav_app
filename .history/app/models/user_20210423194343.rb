class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :user_name, presence: true, length: { maximum: 20 }, uniqueness: true
  # validates :self_introduction,  length: { maximum: 160 }
  # mount_uploader :image, ImgNameUploader
end
