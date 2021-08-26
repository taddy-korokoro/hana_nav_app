FactoryBot.define do
  factory :travel_record do
    sequence(:title) { |n| "TEST_TITLE_#{n}"}
    sequence(:content) { |n| "TEST_CONTENT_#{n}"}
    sequence(:place) { |n| "TEST_PLACE_#{n}"}
    sequence(:review) { |n| n }
    sequence(:visited_on) { |n| n }
  end
end