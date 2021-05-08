# スポットサンプル
10.times do |n|
  Spot.create!(
    name: "spot_#{n+1}",
    location: "location_#{n+1}",
    feature: "きれい！_#{n+1}",
    image: "img_#{n+1}",
    url: "hana_nav_#{n+1}.com",
    latitude: Faker::Address.unique.latitude,
    longitude: Faker::Address.unique.longitude
  )
end

# 花
10.times do |n|
  FlowerItem.create!(
    name: "flower_item_#{n+1}",
    feature: Faker::Color.unique.color_name,
    image: "img_#{n+1}"
  )
end