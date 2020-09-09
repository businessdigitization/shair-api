class Package < ApplicationRecord
  enum status: { draft: 0, published: 1, outdated: 2 }, prefix: :package
  enum delivery_status: { waiting_to_pick_up: 0, picked_up: 1, reached_destination: 2, ready_to_deliver: 3, delivered: 4 }

  validates :status, presence: true

  belongs_to :user
  belongs_to :departure, class_name: 'Place', foreign_key: :departure_id
  belongs_to :destination, class_name: 'Place', foreign_key: :destination_id

  has_many :items, class_name: 'PackageItem'
end

# == Schema Information
#
# Table name: packages
#
#  id                 :bigint           not null, primary key
#  delivery_daterange :daterange
#  description        :text
#  status             :integer          not null
#  weight             :decimal(10, 2)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  departure_id       :bigint           not null
#  destination_id     :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_packages_on_departure_id    (departure_id)
#  index_packages_on_destination_id  (destination_id)
#  index_packages_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_1eabb157c5  (departure_id => places.id)
#  fk_rails_72648286cc  (destination_id => places.id)
#
