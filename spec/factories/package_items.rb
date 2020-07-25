FactoryBot.define do
  factory :package_item do
    name { 'golla' }
    count { 1 }
    association :package, factory: :package
  end
end
