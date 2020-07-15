FactoryBot.define do
  factory :trip do
    journey_date { 7.days.since }
    starts_at { 7.days.since.change({ hour: 5, min: 30 }) }
    ends_at { 7.days.since.change({ hour: 10, min: 30 }) }
    status { :draft }
    association :user, factory: :user
    association :route, factory: :route
  end
end
