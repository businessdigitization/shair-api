class Booking < ApplicationRecord
  self.primary_key = 'number'

  enum status: { proposed: 0, negosiation: 1, accepted: 2, rejected: 3, canceled: 4 }

  belongs_to :trip, inverse_of: :bookings
  belongs_to :package, inverse_of: :bookings
  belongs_to :currency, foreign_key: :currency_code

  delegate :dispatcher, to: :package
  delegate :transporter, to: :trip

  validates :status, presence: true
  validates :number, presence: true
  validate :presence_of_proposed_price
  validate :different_user_as_dispatcher_and_transporter

  after_initialize :init

  private

  def init
    self.status = :proposed
    self.number = (rand(100) * Time.zone.now.to_i).to_s
  end

  private

  def presence_of_proposed_price
    return if dispatcher_proposed_price.present? || transporter_proposed_price.present?

    errors.add(:price, 'Must have a proposed price')
  end

  def different_user_as_dispatcher_and_transporter
    return unless package && trip

    return if package.dispatcher != trip.transporter

    errors.add(:base, "Dispatcher and Transporter can't be same person")
  end
end

# == Schema Information
#
# Table name: bookings
#
#  currency_code              :string           not null
#  dispatcher_proposed_price  :decimal(10, 2)
#  number                     :string           not null, primary key
#  price                      :decimal(10, 2)
#  status                     :integer          not null
#  transporter_proposed_price :decimal(10, 2)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  package_id                 :bigint
#  trip_id                    :bigint
#
# Indexes
#
#  index_bookings_on_currency_code  (currency_code)
#  index_bookings_on_package_id     (package_id)
#  index_bookings_on_trip_id        (trip_id)
#
# Foreign Keys
#
#  fk_rails_dfe6b9db19  (currency_code => currencies.code)
#
