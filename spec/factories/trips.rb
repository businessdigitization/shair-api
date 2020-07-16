FactoryBot.define do
  factory :trip do
    journey_date { 7.days.since }
    status { :planning }
    association :journey_date_range, factory: :date_range
    association :journey_time_range, factory: :time_range
    association :user, factory: :user
    association :route, factory: :route
  end
end
