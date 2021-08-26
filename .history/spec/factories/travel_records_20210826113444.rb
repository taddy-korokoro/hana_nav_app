FactoryBot.define do
  factory :travel_record do
    sequence(:title) { |n| "TEST_TITLE_#{n}"}
    sequence(:content) { |n| "TEST_CONTENT_#{n}"}
    sequence(:place) { |n| "TEST_PLACE_#{n}"}
    sequence(:review) { |n| "TEST_REVIEW_#{n}"}
    sequence(:visited_on) { |n| "TEST_VESITED_ON_#{n}"}
  end
end