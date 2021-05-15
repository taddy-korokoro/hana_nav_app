# 見頃
12.times do |n|
  Season.create!(
    month_name: "#{n+1}月" )
end

# 場所
Area.create!(name: "北海道")
Area.create!(name: "東北")
Area.create!(name: "関東")
Area.create!(name: "中部")
Area.create!(name: "関西")
Area.create!(name: "四国")
Area.create!(name: "中国")
Area.create!(name: "九州")
Area.create!(name: "沖縄")