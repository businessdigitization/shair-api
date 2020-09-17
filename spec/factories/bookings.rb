FactoryBot.define do
  factory :booking do
    status { 'proposed' }
    price { 30 }
    transiter_proposed_price { 25 }
    transporter_proposed_price { 30 }
    association :package, factory: :package
    association :trip, factory: :trip
    association :currency, factory: :currency
  end
end

# == Schema Information
#
# Table name: bookings
#
#  id                         :bigint           not null, primary key
#  price                      :decimal(10, 2)   not null
#  status                     :integer          not null
#  transiter_proposed_price   :decimal(10, 2)   not null
#  transporter_proposed_price :decimal(10, 2)   not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  currency_id                :bigint
#  package_id                 :bigint
#  trip_id                    :bigint
#
# Indexes
#
#  index_bookings_on_currency_id  (currency_id)
#  index_bookings_on_package_id   (package_id)
#  index_bookings_on_trip_id      (trip_id)
#
