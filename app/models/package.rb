class Package < ApplicationRecord
  enum status: { draft: 0, published: 1, outdated: 2 }, prefix: :package
  enum delivery_status: { waiting_to_pick_up: 0, picked_up: 1, reached_destination: 2, ready_to_deliver: 3, delivered: 4 }

  validates :status, presence: true

  belongs_to :user
  belongs_to :departure, class_name: 'Place', foreign_key: :departure_id
  belongs_to :destination, class_name: 'Place', foreign_key: :destination_id

  has_many :items, class_name: 'PackageItem'
end
