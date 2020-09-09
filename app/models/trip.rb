class Trip < ApplicationRecord
  validates :status, presence: true
  enum status: { draft: 0, published: 1, outdated: 2 }, prefix: :trip
  enum trip_type: { air: 0, train: 1, bus: 2, car: 3, ship: 4, mixed: 5, other: 6 }, suffix: :trip

  belongs_to :user
  belongs_to :departure, class_name: 'Place', foreign_key: :departure_id
  belongs_to :destination, class_name: 'Place', foreign_key: :destination_id
end

# * Pricing
#   price_per_unit
#   minimum_price
#   currency

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









w














]
