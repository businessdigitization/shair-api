class ParcelItem < ApplicationRecord
  belongs_to :parcel, inverse_of: :items
  belongs_to :category, class_name: 'ParcelItemCategory', foreign_key: :category_id

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
#  category_id :integer
#  parcel_id   :bigint
#
# Indexes
#
#  index_parcel_items_on_category_id  (category_id)
#  index_parcel_items_on_parcel_id    (parcel_id)
#
# Foreign Keys
#
#  fk_rails_c7865e52f6  (parcel_id => parcels.id)
#  fk_rails_f7eb2d05c2  (category_id => parcel_item_categories.id)
#
