class Route < ApplicationRecord
  validates :from, :to, :route_type, presence: true
  enum route_type: { flight: 0, train: 1, bus: 2, car: 3, ship: 4, mixed: 5, other: 6 }

  has_many :trips
end
