FactoryBot.define do
  factory :parcel_pricing do
    association :parcel, factory: :parcel
    price { 10.00 }
    association :currency, factory: :currency
  end
end

# == Schema Information
#
# Table name: parcel_pricings
#
#  id            :bigint           not null, primary key
#  currency_code :string           not null
#  negotiable    :boolean
#  price         :decimal(10, 2)   not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  parcel_id     :bigint
#
# Indexes
#
#  index_parcel_pricings_on_currency_code  (currency_code)
#  index_parcel_pricings_on_parcel_id      (parcel_id)
#
# Foreign Keys
#
#  fk_rails_e46bd2e8b8  (currency_code => currencies.code)
#
