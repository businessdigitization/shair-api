FactoryBot.define do
  factory :package_pricing do
    association :package, factory: :package
    price { 10.00 }
    association :currency, factory: :currency
  end
end

# == Schema Information
#
# Table name: package_pricings
#
#  id          :bigint           not null, primary key
#  negotiable  :boolean
#  price       :decimal(10, 2)   not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  currency_id :bigint
#  package_id  :bigint
#
# Indexes
#
#  index_package_pricings_on_currency_id  (currency_id)
#  index_package_pricings_on_package_id   (package_id)
#
