class PackageItem < ApplicationRecord
  belongs_to :package, inverse_of: :items

  validates :name, :count, presence: true
end

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
