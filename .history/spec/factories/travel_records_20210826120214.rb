FactoryBot.define do
  factory :travel_record do
    # sequence(:title) { |n| "TEST_TITLE_#{n}"}
    # sequence(:content) { |n| "TEST_CONTENT_#{n}"}
    # sequence(:place) { |n| "TEST_PLACE_#{n}"}
    # sequence(:review) { |n| n }
    # sequence(:visited_on) { |n| n }
    title "TEST_TITLE"
    content "TEST_CONTENT"
    place "TEST_PLACE"
    review 5.0
    visited_on 2021/08/26
  end
end