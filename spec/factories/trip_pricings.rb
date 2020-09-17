# == Schema Information
#
# Table name: trip_pricings
#
#  id            :bigint           not null, primary key
#  minimum_price :decimal(10, 2)   not null
#  negotiable    :boolean
#  unit_price    :decimal(10, 2)   not null
#  currency_id   :bigint
#  trip_id       :bigint
#
# Indexes
#
#  index_trip_pricings_on_currency_id  (currency_id)
#  index_trip_pricings_on_trip_id      (trip_id)
#
FactoryBot.define do
  factory :trip_pricing do
    association :trip, factory: :trip
    unit_price { 10.00 }
    minimum_price { 10.00 }
    association :currency, factory: :currency
  end
end
