class TripPricing < ApplicationRecord
  validates :unit_price, :minimum_price, presence: true

  belongs_to :trip, inverse_of: :pricing
  belongs_to :currency
end

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
