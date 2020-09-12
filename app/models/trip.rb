class Trip < ApplicationRecord
  validates :status, presence: true
  enum status: { draft: 0, published: 1, outdated: 2 }, _suffix: :trip
  enum trip_type: { air: 0, train: 1, bus: 2, car: 3, ship: 4, mixed: 5, other: 6 }, _suffix: :trip

  belongs_to :user
  belongs_to :departure, class_name: 'Place', foreign_key: :departure_id
  belongs_to :destination, class_name: 'Place', foreign_key: :destination_id

  has_one :trip_pricing
end

# * Pricing
#   price_per_unit
#   minimum_price
#   currency

# TripPreference
# PackagePreference

# *Booking
#   trip_id
#   package_id
#   proposed_price_by_transporter
#   proposed_price_by_transiter
#   price
#   currency
#   transporter
#   transiter
#   status: [:proposed, :negosiation, :accepted, :rejected, :canceled]

# == Schema Information
#
# Table name: trips
#
#  id               :bigint           not null, primary key
#  arrival_time     :datetime
#  date             :date
#  departure_time   :datetime
#  luggage_capacity :decimal(5, 2)
#  preference       :text
#  status           :integer          not null
#  trip_type        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  departure_id     :bigint           not null
#  destination_id   :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_trips_on_date            (date)
#  index_trips_on_departure_id    (departure_id)
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_status          (status)
#  index_trips_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_447da15f04  (destination_id => places.id)
#  fk_rails_dfa65b25bf  (departure_id => places.id)
#
