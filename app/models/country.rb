class Country < ApplicationRecord
  has_many :cities, inverse_of: :country
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
#  id         :bigint           not null, primary key
#  code       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_countries_on_code  (code) UNIQUE
#
