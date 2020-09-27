class Package < ApplicationRecord
  enum status: { draft: 0, published: 1, outdated: 2 }, _prefix: :package
  enum delivery_status: { waiting_to_pick_up: 0, picked_up: 1, reached_destination: 2, ready_to_deliver: 3, delivered: 4 }

  belongs_to :dispatcher, class_name: 'User', inverse_of: :packages
  belongs_to :departure, class_name: 'Airport', inverse_of: :outgoing_packages
  belongs_to :destination, class_name: 'Airport', inverse_of: :incoming_packages

  has_one :pricing, class_name: 'PackagePricing', dependent: :destroy, inverse_of: :package
  has_many :items, class_name: 'PackageItem', dependent: :destroy, inverse_of: :package
  has_many :bookings, inverse_of: :package

  validates :status, presence: true

  after_initialize :init

  private

  def init
    self.status = :draft
  end
end

# == Schema Information
#
# Table name: packages
#
#  id                 :bigint           not null, primary key
#  delivery_daterange :daterange
#  description        :text
#  preference         :text
#  status             :integer          not null
#  weight             :decimal(10, 2)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  departure_id       :bigint           not null
#  destination_id     :bigint           not null
#  dispatcher_id      :bigint           not null
#
# Indexes
#
#  index_packages_on_departure_id    (departure_id)
#  index_packages_on_destination_id  (destination_id)
#  index_packages_on_dispatcher_id   (dispatcher_id)
#
# Foreign Keys
#
#  fk_rails_1eabb157c5  (departure_id => airports.id)
#  fk_rails_72648286cc  (destination_id => airports.id)
#  fk_rails_ccab535bef  (dispatcher_id => users.id)
#
