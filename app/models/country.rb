class Country < ApplicationRecord
  self.primary_key = 'code'

  has_many :cities, primary_key: :code, foreign_key: :country_code, inverse_of: :country
  has_many :airports, through: :cities

  validates :code, presence: true
  validates :code, uniqueness: true
  validates :code, format: %r(\A[A-Z]{2}\z)
  validates :name, presence: true
end

# == Schema Information
#
# Table name: countries
#
#  code       :string           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
