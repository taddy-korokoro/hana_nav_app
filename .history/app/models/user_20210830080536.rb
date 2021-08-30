class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :travel_records, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :followers, through: :follower_relationships

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :self_introduction,  length: { maximum: 300 }

  mount_uploader :profile_image, ImageUploader

  # ゲストログイン機能の設定
  def self.guest
    find_or_create_by!(email: 'guest@exsample.com') do | user |
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.self_introduction = "ご自由にお使いください"
    end
  end

  # パスワードの更新
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

  # フォロー済みかどうか判定
  def following?(user)
    self.followings.include?(user)
  end
  # ユーザーをフォローする
  def follow!(user)
    self.following_relationships.create(following_id: user.id)
  end
  # ユーザーのフォローを解除する
  def unfollow(user)
    self.following_relationships.find_by(following_id: user.id).destroy
  end
  # フォローしているユーザーが投稿したデータを取得
  def feed
    TravelRecord.where(user_id: following_ids)
  end
  # ソート機能の設定
  ransacker :travel_records_count do
    query = '(SELECT COUNT(travel_records.user_id) FROM travel_records where travel_records.user_id = users.id GROUP BY travel_records.user_id)'
    Arel.sql(query)
  end
  ransacker :likes_count do
    query = '(SELECT COUNT(likes.user_id) FROM likes where likes.user_id = users.id GROUP BY likes.user_id)'
    Arel.sql(query)
  end
end
