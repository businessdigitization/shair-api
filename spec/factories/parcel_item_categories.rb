FactoryBot.define do
  factory :parcel_item_category do
    name { 'Home Appliance'}
  end
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
