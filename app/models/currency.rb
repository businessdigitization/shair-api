class Currency < ApplicationRecord
  validates :name, :code, presence: true
end

# == Schema Information
#
# Table name: currencies
#
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
