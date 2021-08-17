# 見頃
# 12.times do |n|
#   Season.create!(
#     id: n+1,
#     month_name: "#{n+1}月" )
# end

# 場所
# Area.create!(id: 1, name: "北海道")
# Area.create!(id: 2, name: "東北")
# Area.create!(id: 3, name: "関東")
# Area.create!(id: 4, name: "中部")
# Area.create!(id: 5, name: "関西")
# Area.create!(id: 6, name: "四国")
# Area.create!(id: 7, name: "中国")
# Area.create!(id: 8, name: "九州")
# Area.create!(id: 9, name: "沖縄")

require 'csv'

CSV.foreach('db/csv_data/flower_item.csv', headers: true) do |row|
  FlowerItem.create(
    name: row['name'],
    time: row['time'],
    feature: row['feature'],
    image: row['image']
  )
end