# スポットサンプル
# 10.times do |n|
#   Spot.create!(
#     name: "spot#{n+1}",
#     location: "location#{n+1}",
#     feature: "きれい！#{n+1}",
#     image: "img_#{n+1}",
#     url: "hana_nav_#{n+1}.com",
#     latitude: Faker::Address.unique.latitude,
#     longitude: Faker::Address.unique.longitude
#   )
# end

# 花
10.times do |n|
  FlowerItem.create!(
    name: "flower_item#{n+1}",
    feature: Faker::Color.unique.color_name,
    image: "img_#{n+1}",
    season_id: "#{n+1}"
  )
end