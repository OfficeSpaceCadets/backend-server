FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "John Doe #{n}" }
    username { name.split.join('.') }
    sequence(:external_id) {|id| "abc#{id}" }
    email { "#{username}@example.com" }
  end
end
