class Trip < ApplicationRecord
  validates :status, presence: true
  enum status: { draft: 0, published: 1, outdated: 2 }
  enum trip_type: { air: 0, train: 1, bus: 2, car: 3, ship: 4, mixed: 5, other: 6 }

  belongs_to :user
  belongs_to :departure, class_name: 'Place', foreign_key: :departure_id
  belongs_to :destination, class_name: 'Place', foreign_key: :destination_id

end

# * Package
#   description
#   weight
#   package_items

# *PackageItem
#   package_id
#   name
#   weight
#   height
#   count

# *BookingProposal
#   trip_id
#   package_id
#   proposed_price
#   final_price
#   status: [:proposed, :negosiation, :accepted, :rejected]

# *Booking
#   trip_id
