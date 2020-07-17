FactoryBot.define do
  factory :trip do
    departure { 'Kuala Lumpur' }
    destination { 'Dhaka' }
    date { 7.days.since }
    status { :draft }
    association :user, factory: :user
  end
end
