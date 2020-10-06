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
#  id            :bigint           not null, primary key
#  currency_code :string           not null
#  negotiable    :boolean
#  price         :decimal(10, 2)   not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  package_id    :bigint
#
# Indexes
#
#  index_package_pricings_on_currency_code  (currency_code)
#  index_package_pricings_on_package_id     (package_id)
#
# Foreign Keys
#
#  fk_rails_2de66a46aa  (currency_code => currencies.code)
#
