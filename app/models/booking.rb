class Booking < ApplicationRecord
  enum status: { proposed: 0, negosiation: 1, accepted: 2, rejected: 3, canceled: 4 }

  belongs_to :trip, inverse_of: :bookings
  belongs_to :package, inverse_of: :bookings
  belongs_to :currency

  validates :status, presence: true
  validate :presence_of_proposed_price
  validate :different_user_as_transiter_and_transporter

  private

  def presence_of_proposed_price
    return if (transiter_proposed_price.present? || transporter_proposed_price.present?)

    errors.add(:price, 'Must have a proposed price')
  end

  def different_user_as_transiter_and_transporter
    return unless package && trip

    return if package.transiter != trip.transporter

    errors.add(:base, "Transiter and Transporter can't be same person")
  end
end

# == Schema Information
#
# Table name: bookings
#
#  id                         :bigint           not null, primary key
#  price                      :decimal(10, 2)   not null
#  status                     :integer          not null
#  transiter_proposed_price   :decimal(10, 2)   not null
#  transporter_proposed_price :decimal(10, 2)   not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  currency_id                :bigint
#  package_id                 :bigint
#  trip_id                    :bigint
#
# Indexes
#
#  index_bookings_on_currency_id  (currency_id)
#  index_bookings_on_package_id   (package_id)
#  index_bookings_on_trip_id      (trip_id)
#