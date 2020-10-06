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
#  currency_code              :string           not null
#  dispatcher_proposed_price  :decimal(10, 2)
#  number                     :string           not null, primary key
#  price                      :decimal(10, 2)
#  status                     :integer          not null
#  transporter_proposed_price :decimal(10, 2)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  package_id                 :bigint
#  trip_id                    :bigint
#
# Indexes
#
#  index_bookings_on_currency_code  (currency_code)
#  index_bookings_on_package_id     (package_id)
#  index_bookings_on_trip_id        (trip_id)
#
# Foreign Keys
#
#  fk_rails_dfe6b9db19  (currency_code => currencies.code)
#
