10.times do |n|
  User.create!(
    name: "旅人番号#{n+1}",
    email: "example_#{n+1}@gmail.com",
    password: 11111111
  )
end