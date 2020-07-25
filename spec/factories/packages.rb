FactoryBot.define do
  factory :package do
    description { 'My Precious' }
    association :departure, factory: :place_kl
    association :destination, factory: :place_dhaka
    weight { 5 }
    status { 'draft' }
  end
end
