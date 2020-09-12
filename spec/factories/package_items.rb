# == Schema Information
#
# Table name: package_items
#
#  id          :bigint           not null, primary key
#  count       :integer          default(1), not null
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  package_id  :bigint
#
# Indexes
#
#  index_package_items_on_package_id  (package_id)
#
FactoryBot.define do
  factory :package_item do
    name { 'golla' }
    count { 1 }
    association :package, factory: :package
  end
end
