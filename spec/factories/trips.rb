FactoryBot.define do
  factory :trip do
    association :departure, factory: :place
    association :destination, factory: :place_kl
    date { 7.days.since }
    status { :draft }
    association :user, factory: :user
  end
end
