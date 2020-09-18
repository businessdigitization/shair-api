class Airport < ApplicationRecord
  belongs_to :city, inverse_of: :airports

  has_many :incoming_packages, class_name: 'Package', foreign_key: :destination_id, inverse_of: :destination
  has_many :outgoing_packages, class_name: 'Package', foreign_key: :destination_id, inverse_of: :departure
  has_many :incoming_trips, class_name: 'Trip', foreign_key: :destination_id, inverse_of: :destination
  has_many :outgoing_trips, class_name: 'Trip', foreign_key: :destination_id, inverse_of: :departure

  validates :code, presence: true
  validates :code, uniqueness: true
  validates :code, format: %r(\A[A-Z]{3}\z)

  validates :name, presence: true
end

# == Schema Information
#
# Table name: airports
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :bigint
#
# Indexes
#
#  index_airports_on_city_id  (city_id)
#  index_airports_on_code     (code) UNIQUE
#  index_airports_on_name     (name)
#
