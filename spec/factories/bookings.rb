FactoryBot.define do
  factory :booking do
    status { 'proposed' }
    price { 30 }
    dispatcher_proposed_price { 25 }
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
#  dispatcher_proposed_price  :decimal(10, 2)
#  number                     :string           not null
#  price                      :decimal(10, 2)
#  status                     :integer          not null
#  transporter_proposed_price :decimal(10, 2)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  currency_id                :bigint
#  package_id                 :bigint
#  trip_id                    :bigint
#
# Indexes
#
#  index_bookings_on_currency_id  (currency_id)
#  index_bookings_on_number       (number)
#  index_bookings_on_package_id   (package_id)
#  index_bookings_on_trip_id      (trip_id)
#
