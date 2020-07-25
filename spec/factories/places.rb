FactoryBot.define do
  factory :place do
    name { 'London' }

    factory :place_kl do
      name { 'Kuala Lumpur' }
    end

    factory :place_dhaka do
      name { 'Dhaka' }
    end
  end
end
