class Place < ApplicationRecord
  validates :name, presence: true
end

# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  name       :citext           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
