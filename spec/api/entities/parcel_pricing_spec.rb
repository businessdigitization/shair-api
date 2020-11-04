require 'rails_helper'

RSpec.describe Entities::ParcelPricing do
  let(:parcel_pricing) { FactoryBot.create(:parcel_pricing) }
  let(:parcel_pricing_entity) { Entities::ParcelPricing.represent(parcel_pricing) }

  subject { JSON.parse(parcel_pricing_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => parcel_pricing.id,
        'price' => parcel_pricing.price,
        'currency' => {
          'name' => parcel_pricing.currency.name,
          'code' => parcel_pricing.currency.code,
        },
        'negotiable' => parcel_pricing.negotiable,
      )
  end
end
