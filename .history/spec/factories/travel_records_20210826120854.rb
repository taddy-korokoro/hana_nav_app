FactoryBot.define do
  factory :travel_record do
    title { "TEST_TITLE" }
    content { "TEST_CONTENT" }
    place { "TEST_PLACE" }
    review { 5.0 }
    visited_on { "2021/08/26" }
  end
end