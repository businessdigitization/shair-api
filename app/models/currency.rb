class Currency < ApplicationRecord
  validates :name, :code, presence: true
  validates :code, format: %r(\A[A-Z]{3}\z), uniqueness: true
end

# == Schema Information
#
# Table name: currencies
#
#  id   :bigint           not null, primary key
#  code :string           not null
#  name :string           not null
#
# Indexes
#
#  index_currencies_on_code  (code) UNIQUE
#
