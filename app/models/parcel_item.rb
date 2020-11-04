class ParcelItem < ApplicationRecord
  belongs_to :parcel, inverse_of: :items
  belongs_to :item_type, class_name: 'ParcelItemType', foreign_key: :item_type_id

  validates :name, :count, presence: true
end

# == Schema Information
#
# Table name: parcel_items
#
#  id           :bigint           not null, primary key
#  count        :integer          default(1), not null
#  description  :text
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  item_type_id :integer
#  parcel_id    :bigint
#
# Indexes
#
#  index_parcel_items_on_item_type_id  (item_type_id)
#  index_parcel_items_on_parcel_id     (parcel_id)
#
# Foreign Keys
#
#  fk_rails_56491c5e2e  (item_type_id => parcel_item_types.id)
#  fk_rails_c7865e52f6  (parcel_id => parcels.id)
#
