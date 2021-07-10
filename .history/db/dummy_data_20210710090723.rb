# user_sample
50.times do |n|
  User.create!(
    name: Faker::Name.unique.name,
    # name: "user_#{n+1}",
    email: "example-#{n+1}@rails.org",
    password: "password",
    profile_image: open("./db/fixtures/no_image.png"),
    self_introduction: "よろしくお願いします。"
  )
end

# spot_sample
9.times do |n|
  Spot.create!(
    id: n+1,
    name: "spot_#{n+1}",
    location: "location_#{n+1}",
    feature: "きれい",
    image: "img_#{n+1}",
    url: "hana_nav_#{n+1}.com",
    latitude: Faker::Address.unique.latitude,
    longitude: Faker::Address.unique.longitude,
    area_id: n+1
  )
end

# flower_item_sample
9.times do |n|
  FlowerItem.create!(
    id: n+1,
    name: "flower_item_#{n+1}",
    feature: "#{Faker::Color.unique.color_name}できれい",
    image: "img_#{n+1}",
    season_id: n+1
  )
end

# spotsとflower_itemsの中間テーブル
9.times do |n|
  FlowerItemSpot.create!(
    id: n+1,
    spot_id: n+1,
    flower_item_id: n+1
  )
end