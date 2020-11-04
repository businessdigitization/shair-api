class ParcelPricing < ApplicationRecord
  belongs_to :parcel, inverse_of: :pricing
  belongs_to :currency, foreign_key: :currency_code

  validates :price, presence: true
end

# == Schema Information
#
# Table name: parcel_pricings
#
#  id            :bigint           not null, primary key
#  currency_code :string           not null
#  negotiable    :boolean
#  price         :decimal(10, 2)   not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  parcel_id     :bigint
#
# Indexes
#
#  index_parcel_pricings_on_currency_code  (currency_code)
#  index_parcel_pricings_on_parcel_id      (parcel_id)
#
# Foreign Keys
#
#  fk_rails_19ac3f04f4  (parcel_id => parcels.id)
#  fk_rails_e46bd2e8b8  (currency_code => currencies.code)
#
