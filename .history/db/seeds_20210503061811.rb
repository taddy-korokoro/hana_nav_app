

# 見頃
12.times do |n|
  Season.create!(
    season: "#{n+1}月" )
end

# 場所
Area.create!(area: "北海道")
Area.create!(area: "東北")
Area.create!(area: "関東")
Area.create!(area: "中部")
Area.create!(area: "関西")
Area.create!(area: "四国")
Area.create!(area: "中国")
Area.create!(area: "九州")
Area.create!(area: "沖縄")

# 花
# FlowerItem.create!(
#   name: "flower_item#{n+1}",
#   feature: ""
# )