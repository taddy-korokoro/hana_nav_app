# user_sample
50.times do |n|
  User.create!(
    name: "user_#{n+1}",
    email: "example-#{n+1}@rails.org",
    password: "password",
    profile_image: open("./db/fixtures/no_image.png"),
    self_introduction: "よろしくお願いします。"
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