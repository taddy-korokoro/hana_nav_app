# スポットサンプル
10.times do |n|
  Spot.create!(
    name: "spot#{n+1}",
    location: "location#{n+1}",
    season: "#{n+1}月",
    feature: "きれい！#{n+1}"
  )
end

# 花
10.times do |n|
  FlowerItem.create!(
    name: "flower_item#{n+1}",
    feature: Faker::Color.color_name,
    img: "img_#{n+1}"
  )
end