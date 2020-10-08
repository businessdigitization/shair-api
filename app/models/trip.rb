class Trip < ApplicationRecord
  enum status: { draft: 0, published: 1, outdated: 2 }, _suffix: :trip

  belongs_to :transporter, class_name: 'User', foreign_key: :transporter_email, inverse_of: :trips
  belongs_to :origin, class_name: 'Airport', foreign_key: :origin_airport_code, inverse_of: :outgoing_trips
  belongs_to :destination, class_name: 'Airport', foreign_key: :destination_airport_code, inverse_of: :incoming_trips

  has_one :pricing, class_name: 'TripPricing', dependent: :destroy, inverse_of: :trip
  has_many :bookings, inverse_of: :trip

  validates :status, presence: true
  validate :departure_before_arrival

  validates :arrival_at, :departure_at, :luggage_capacity, :pricing, presence: true, if: :published_trip?

  accepts_nested_attributes_for :pricing

  after_initialize :init

  private

  def departure_before_arrival
    return if (departure_at.nil? || arrival_at.nil?) || departure_at < arrival_at

    errors.add(:departure_at, 'Time travel not possible')
  end

  def init
    return unless new_record?

    self.status = :draft
  end
end

# == Schema Information
#
# Table name: trips
#
#  id                       :bigint           not null, primary key
#  arrival_at               :datetime
#  departure_at             :datetime
#  destination_airport_code :string           not null
#  luggage_capacity         :decimal(5, 2)
#  origin_airport_code      :string           not null
#  preference               :text
#  status                   :integer          not null
#  transporter_email        :citext           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_trips_on_arrival_at                (arrival_at)
#  index_trips_on_departure_at              (departure_at)
#  index_trips_on_destination_airport_code  (destination_airport_code)
#  index_trips_on_origin_airport_code       (origin_airport_code)
#  index_trips_on_status                    (status)
#  index_trips_on_transporter_email         (transporter_email)
#
# Foreign Keys
#
#  fk_rails_4bad16e1b6  (origin_airport_code => airports.code)
#  fk_rails_74bfde5700  (destination_airport_code => airports.code)
#  fk_rails_fc6bcf6577  (transporter_email => users.email)
#
