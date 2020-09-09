class PackageItem < ApplicationRecord
  belongs_to :package

  validates :name, :count, presence: true
end

# == Schema Information
#
# Table name: package_items
#
#  id          :bigint           not null, primary key
#  count       :integer
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  package_id  :bigint
#
# Indexes
#
#  index_package_items_on_package_id  (package_id)
#
