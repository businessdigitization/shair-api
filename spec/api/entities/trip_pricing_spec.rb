require 'rails_helper'

RSpec.describe Entities::TripPricing do
  let(:trip_pricing) { FactoryBot.create(:trip_pricing) }
  let(:trip_pricing_entity) { Entities::TripPricing.represent(trip_pricing) }

  subject { JSON.parse(trip_pricing_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => trip_pricing.id,
        'unit_price' => trip_pricing.unit_price,
        'minimum_price' => trip_pricing.minimum_price,
        'currency' => {
          'name' => trip_pricing.currency.name,
          'code' => trip_pricing.currency.code,
        },
        'negotiable' => trip_pricing.negotiable,
      )
  end
end
