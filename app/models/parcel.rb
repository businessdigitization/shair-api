class Parcel < ApplicationRecord
  enum status: { draft: 0, published: 1, outdated: 2 }, _prefix: :parcel
  enum delivery_status: { waiting_to_pick_up: 0, picked_up: 1, reached_destination: 2, ready_to_deliver: 3, delivered: 4 }

  belongs_to :dispatcher, class_name: 'User', foreign_key: :dispatcher_email, inverse_of: :parcels
  belongs_to :origin, class_name: 'Airport', foreign_key: :origin_airport_code, inverse_of: :outgoing_parcels
  belongs_to :destination, class_name: 'Airport', foreign_key: :destination_airport_code, inverse_of: :incoming_parcels

  has_one :pricing, class_name: 'ParcelPricing', dependent: :destroy, inverse_of: :parcel
  has_many :items, class_name: 'ParcelItem', dependent: :destroy, inverse_of: :parcel
  has_many :bookings, inverse_of: :parcel

  validates :status, presence: true
  validates :items, :weight, presence: true, if: :parcel_published?

  accepts_nested_attributes_for :pricing
  accepts_nested_attributes_for :items, allow_destroy: true

  after_initialize :init

  private

  def init
    return unless new_record?

    self.status = :draft
  end
end

# == Schema Information
#
# Table name: parcels
#
#  id                       :bigint           not null, primary key
#  description              :text
#  destination_airport_code :string           not null
#  dispatcher_email         :citext           not null
#  origin_airport_code      :string           not null
#  preference               :text
#  status                   :integer          not null
#  weight                   :decimal(10, 2)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_parcels_on_destination_airport_code  (destination_airport_code)
#  index_parcels_on_dispatcher_email          (dispatcher_email)
#  index_parcels_on_origin_airport_code       (origin_airport_code)
#
# Foreign Keys
#
#  fk_rails_84b18934e0  (dispatcher_email => users.email)
#  fk_rails_96a9186c76  (origin_airport_code => airports.code)
#  fk_rails_ae01c8cf55  (destination_airport_code => airports.code)
#
