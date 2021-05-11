# # スポットサンプル
# 9.times do |n|
#   Spot.create!(
#     name: "spot_#{n+1}",
#     location: "location_#{n+1}",
#     feature: "きれい",
#     image: "img_#{n+1}",
#     url: "hana_nav_#{n+1}.com",
#     latitude: Faker::Address.unique.latitude,
#     longitude: Faker::Address.unique.longitude,
#     area_id: n+1
#   )
# end

# # 花
# 9.times do |n|
#   FlowerItem.create!(
#     name: "flower_item_#{n+1}",
#     feature: "#{Faker::Color.unique.color_name}できれい",
#     image: "img_#{n+1}",
#     season_id: n+1
#   )
# end

# # spotsとflower_itemsの中間テーブル
# 9.times do |n|
#   FlowerItemSpot.create!(
#     spot_id: n+1,
#     flower_item_id: n+1
#   )
end