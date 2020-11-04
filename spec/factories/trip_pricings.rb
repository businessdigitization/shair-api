# == Schema Information
#
# Table name: trip_pricings
#
#  id            :bigint           not null, primary key
#  currency_code :string           not null
#  minimum_price :decimal(10, 2)   not null
#  negotiable    :boolean
#  unit_price    :decimal(10, 2)   not null
#  trip_id       :bigint
#
# Indexes
#
#  index_trip_pricings_on_currency_code  (currency_code)
#  index_trip_pricings_on_trip_id        (trip_id)
#
# Foreign Keys
#
#  fk_rails_7f0e63a6c4  (trip_id => trips.id)
#  fk_rails_809d280049  (currency_code => currencies.code)
#
FactoryBot.define do
  factory :trip_pricing do
    association :trip, factory: :trip
    unit_price { 10.00 }
    minimum_price { 10.00 }
    association :currency, factory: :currency
  end
end
