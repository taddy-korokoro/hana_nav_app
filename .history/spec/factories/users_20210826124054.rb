FactoryBot.define do
  factory :user do
    name { "TEST_NAME" }
    email { "TEST_EMAIL@example.com" }
    encrypted_password { "TEST_EMAIL@example.com" }
  end
end