# user_sample
User.create!(
    name: "cat",
    email: "example-1@rails.org",
    password: "11111111",
    profile_image: open("./db/fixtures/cat.jpeg"),
    self_introduction: "よろしくお願いします。"
  )

# spotsとflower_itemsの中間テーブル
# 9.times do |n|
#   FlowerItemSpot.create!(
#     id: n+1,
#     spot_id: n+1,
#     flower_item_id: n+1
#   )
# end