class Currency < ApplicationRecord
  self.primary_key = 'code'

  validates :name, :code, presence: true
  validates :code, format: %r(\A[A-Z]{3}\z), uniqueness: true
end

# == Schema Information
#
# Table name: currencies
#
#  code :string           not null, primary key
#  name :string           not null
#
