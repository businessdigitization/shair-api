class Airport < ApplicationRecord
  self.primary_key = 'code'

  belongs_to :city, inverse_of: :airports

  has_many :incoming_packages, class_name: 'Package', foreign_key: :destination_id, inverse_of: :destination
  has_many :outgoing_packages, class_name: 'Package', foreign_key: :destination_id, inverse_of: :origin
  has_many :incoming_trips, class_name: 'Trip', primary_key: :code, foreign_key: :destination_airport_code, inverse_of: :destination
  has_many :outgoing_trips, class_name: 'Trip', primary_key: :code, foreign_key: :destination_airport_code, inverse_of: :origin

  validates :code, presence: true
  validates :code, uniqueness: true
  validates :code, format: %r(\A[A-Z]{3}\z)

  validates :name, presence: true

  def to_s
    city.name + ', ' + city.country.name + ', ' + code
  end
end

# == Schema Information
#
# Table name: airports
#
#  code       :string           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :bigint
#
# Indexes
#
#  index_airports_on_city_id  (city_id)
#  index_airports_on_name     (name)
#
