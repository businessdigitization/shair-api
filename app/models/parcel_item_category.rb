class ParcelItemCategory < ApplicationRecord
  validates :name, presence: true
end

# == Schema Information
#
# Table name: parcel_item_categories
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
