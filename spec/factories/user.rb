FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "John Doe #{n}" }
    username { name.split.join('.') }
    email { "#{username}@example.com" }
  end
end
