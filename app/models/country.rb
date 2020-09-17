class Country < ApplicationRecord
  validates :code, presence: true
  validates :code, uniqueness: true
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
