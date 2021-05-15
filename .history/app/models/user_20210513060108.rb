class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  validates :user_name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :self_introduction,  length: { maximum: 160 }

  mount_uploader :image, ProfileImgUploader

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
