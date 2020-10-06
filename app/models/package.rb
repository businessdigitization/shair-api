class Package < ApplicationRecord
  enum status: { draft: 0, published: 1, outdated: 2 }, _prefix: :package
  enum delivery_status: { waiting_to_pick_up: 0, picked_up: 1, reached_destination: 2, ready_to_deliver: 3, delivered: 4 }

  belongs_to :dispatcher, class_name: 'User', foreign_key: :dispatcher_email, inverse_of: :packages
  belongs_to :departure, class_name: 'Airport', foreign_key: :departure_airport_code, inverse_of: :outgoing_packages
  belongs_to :destination, class_name: 'Airport', foreign_key: :destination_airport_code, inverse_of: :incoming_packages

  has_one :pricing, class_name: 'PackagePricing', dependent: :destroy, inverse_of: :package
  has_many :items, class_name: 'PackageItem', dependent: :destroy, inverse_of: :package
  has_many :bookings, inverse_of: :package

  validates :status, presence: true

  after_initialize :init

  private

  def init
    return if self.persisted?

    self.status = :draft
  end
end

# == Schema Information
#
# Table name: packages
#
#  id                       :bigint           not null, primary key
#  delivery_daterange       :daterange
#  departure_airport_code   :string           not null
#  description              :text
#  destination_airport_code :string           not null
#  dispatcher_email         :citext           not null
#  preference               :text
#  status                   :integer          not null
#  weight                   :decimal(10, 2)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_packages_on_departure_airport_code    (departure_airport_code)
#  index_packages_on_destination_airport_code  (destination_airport_code)
#  index_packages_on_dispatcher_email          (dispatcher_email)
#
# Foreign Keys
#
#  fk_rails_9e103c4ae1  (departure_airport_code => airports.code)
#  fk_rails_9fa2f5e26f  (destination_airport_code => airports.code)
#  fk_rails_f360845797  (dispatcher_email => users.email)
#
