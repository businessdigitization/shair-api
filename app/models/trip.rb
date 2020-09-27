class Trip < ApplicationRecord
  enum status: { draft: 0, published: 1, outdated: 2 }, _suffix: :trip

  belongs_to :transporter, class_name: 'User', inverse_of: :trips
  belongs_to :departure, class_name: 'Airport', inverse_of: :outgoing_trips
  belongs_to :destination, class_name: 'Airport', inverse_of: :incoming_trips

  has_one :pricing, class_name: 'TripPricing', dependent: :destroy, inverse_of: :trip
  has_many :bookings, inverse_of: :trip

  validates :status, presence: true
  validate :departure_before_arrival

  accepts_nested_attributes_for :pricing

  after_initialize :init

  private

  def departure_before_arrival
    return if (departure_at.nil? || arrival_at.nil?) || departure_at < arrival_at

    errors.add(:departure_at, 'Time travel not possible')
  end

  def init
    self.status = :draft
  end
end

# == Schema Information
#
# Table name: trips
#
#  id               :bigint           not null, primary key
#  arrival_at       :datetime
#  departure_at     :datetime
#  luggage_capacity :decimal(5, 2)
#  preference       :text
#  status           :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  departure_id     :bigint           not null
#  destination_id   :bigint           not null
#  transporter_id   :bigint           not null
#
# Indexes
#
#  index_trips_on_arrival_at      (arrival_at)
#  index_trips_on_departure_at    (departure_at)
#  index_trips_on_departure_id    (departure_id)
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_status          (status)
#  index_trips_on_transporter_id  (transporter_id)
#
# Foreign Keys
#
#  fk_rails_1853b836c1  (transporter_id => users.id)
#  fk_rails_447da15f04  (destination_id => airports.id)
#  fk_rails_dfa65b25bf  (departure_id => airports.id)
#
