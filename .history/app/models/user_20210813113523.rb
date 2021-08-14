class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :travel_records, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :self_introduction,  length: { maximum: 300 }

  mount_uploader :profile_image, ImageUploader

  #ゲストログイン機能の設定
  def self.guest
    find_or_create_by!(email: 'guest@exsample.com') do | user |
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  #パスワードの更新
  def update_without_current_password(params, *options)
    #パスワード変更のためのパスワード入力フィールドとその確認フィールドの両者とも空の場合のみ、
    #パスワードなしで更新できるようにする
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end
  #フォロー済みかどうか判定
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  #ユーザーをフォローする
  def follow(user)
    passive_relationships.create(following_id: user.id)
  end
  #ユーザーのフォローを解除する
  def unfollow(user)
    passive_relationships.find_by(following_id: user.id).destroy
  end
end
