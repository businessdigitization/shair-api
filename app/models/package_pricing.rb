class PackagePricing < ApplicationRecord
  validates :price, presence: true

  belongs_to :package, inverse_of: :pricing
  belongs_to :currency
end

# == Schema Information
#
# Table name: package_pricings
#
#  id          :bigint           not null, primary key
#  negotiable  :boolean
#  price       :decimal(10, 2)   not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  currency_id :bigint
#  package_id  :bigint
#
# Indexes
#
#  index_package_pricings_on_currency_id  (currency_id)
#  index_package_pricings_on_package_id   (package_id)
#
