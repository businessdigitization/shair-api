class ParcelItem < ApplicationRecord
  belongs_to :parcel, inverse_of: :items

  validates :name, :count, presence: true
end

# == Schema Information
#
# Table name: parcel_items
#
#  id          :bigint           not null, primary key
#  count       :integer          default(1), not null
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  parcel_id   :bigint
#
# Indexes
#
#  index_parcel_items_on_parcel_id  (parcel_id)
#
