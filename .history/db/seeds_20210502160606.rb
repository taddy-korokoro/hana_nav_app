# スポットサンプル
10.times do |n|
  Spot.create!(
    name: "spot#{n+1}",
    location: "location#{n+1}",
    season: "#{n+1}月",
    feature: "きれい！#{n+1}" )
end

12.times do |n|
  Season.create!(
    season: "#{n+1}月" )
end