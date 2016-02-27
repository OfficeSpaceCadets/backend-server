FactoryGirl.define do
  factory :pairing_session do
    start_time 10.minutes.ago
    end_time Time.now
  end
end
