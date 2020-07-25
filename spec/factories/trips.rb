FactoryBot.define do
  factory :trip do
    association :departure, factory: :place_kl
    association :destination, factory: :place_dhaka
    date { 7.days.since }
    status { :draft }
    association :user, factory: :user
  end
end
