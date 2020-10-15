class Package < ApplicationRecord
  enum status: { draft: 0, published: 1, outdated: 2 }, _prefix: :package
  enum delivery_status: { waiting_to_pick_up: 0, picked_up: 1, reached_destination: 2, ready_to_deliver: 3, delivered: 4 }

  belongs_to :dispatcher, class_name: 'User', foreign_key: :dispatcher_email, inverse_of: :packages
  belongs_to :origin, class_name: 'Airport', foreign_key: :origin_airport_code, inverse_of: :outgoing_packages
  belongs_to :destination, class_name: 'Airport', foreign_key: :destination_airport_code, inverse_of: :incoming_packages

  has_one :pricing, class_name: 'PackagePricing', dependent: :destroy, inverse_of: :package
  has_many :items, class_name: 'PackageItem', dependent: :destroy, inverse_of: :package
  has_many :bookings, inverse_of: :package

  validates :status, presence: true
  validates :items, :weight, presence: true, if: :package_published?

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
# Table name: packages
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
#  index_packages_on_destination_airport_code  (destination_airport_code)
#  index_packages_on_dispatcher_email          (dispatcher_email)
#  index_packages_on_origin_airport_code       (origin_airport_code)
#
# Foreign Keys
#
#  fk_rails_9fa2f5e26f  (destination_airport_code => airports.code)
#  fk_rails_f360845797  (dispatcher_email => users.email)
#  fk_rails_f4ca4bc327  (origin_airport_code => airports.code)
#
