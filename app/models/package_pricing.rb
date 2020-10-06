class PackagePricing < ApplicationRecord
  belongs_to :package, inverse_of: :pricing
  belongs_to :currency, foreign_key: :currency_code

  validates :price, presence: true
end

# == Schema Information
#
# Table name: package_pricings
#
#  id            :bigint           not null, primary key
#  currency_code :string           not null
#  negotiable    :boolean
#  price         :decimal(10, 2)   not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  package_id    :bigint
#
# Indexes
#
#  index_package_pricings_on_currency_code  (currency_code)
#  index_package_pricings_on_package_id     (package_id)
#
# Foreign Keys
#
#  fk_rails_2de66a46aa  (currency_code => currencies.code)
#
