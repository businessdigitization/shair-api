class City < ApplicationRecord
  belongs_to :country, foreign_key: :country_code, inverse_of: :cities
  has_many :airports, inverse_of: :city
  validates :name, presence: true
end

# == Schema Information
#
# Table name: cities
#
#  id           :bigint           not null, primary key
#  country_code :string           not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_cities_on_country_code  (country_code)
#
# Foreign Keys
#
#  fk_rails_3a43dc511e  (country_code => countries.code)
#
