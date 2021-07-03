class User < ApplicationRecord
  has_many :travel_records, dependent: :destroy

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :self_introduction,  length: { maximum: 300 }

  mount_uploader :profile_image, ProfileImageUploader

# 　ゲストログイン機能の設定
  def self.guest
    find_or_create_by!(email: 'guest@exsample.com') do | user |
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  #パスワードの更新
  def update_without_current_password(params, *options)
    # パスワード変更のためのパスワード入力フィールドとその確認フィールドの両者とも空の場合のみ、
    # パスワードなしで更新できるようにする
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end
end
