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
FactoryBot.define do
  factory :parcel_item do
    name { 'golla' }
    count { 1 }
    association :parcel, factory: :parcel
    association :item_type, factory: :parcel_item_type

  end
end
