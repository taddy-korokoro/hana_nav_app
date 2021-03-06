# 見頃データ
12.times do |n|
  Season.create!(
    id: n+1,
    month_name: "#{n+1}月" )
end

# 場所データ
Area.create!(id: 1, name: "北海道")
Area.create!(id: 2, name: "東北")
Area.create!(id: 3, name: "関東")
Area.create!(id: 4, name: "中部")
Area.create!(id: 5, name: "関西")
Area.create!(id: 6, name: "四国")
Area.create!(id: 7, name: "中国")
Area.create!(id: 8, name: "九州")
Area.create!(id: 9, name: "沖縄")

# sample_user
User.create!(
  name: "猫",
  email: "cat@rails.org",
  password: "11111111",
  profile_image: open("./db/fixtures/cat.jpeg"),
  self_introduction: "吾輩は猫である。"
)