class Trip < ApplicationRecord
  validates :status, presence: true
  enum status: { draft: 0, published: 1, booked: 3, in_progress: 4, complete: 5, outdated: 6 }
  enum trip_type: { air: 0, train: 1, bus: 2, car: 3, ship: 4, mixed: 5, other: 6 }

  belongs_to :user
end
