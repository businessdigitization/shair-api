require 'rails_helper'

RSpec.describe Entities::PackagePricing do
  let(:package_pricing) { FactoryBot.create(:package_pricing) }
  let(:package_pricing_entity) { Entities::PackagePricing.represent(package_pricing) }

  subject { JSON.parse(package_pricing_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => package_pricing.id,
        'price' => package_pricing.price,
        'currency' => {
          'name' => package_pricing.currency.name,
          'code' => package_pricing.currency.code,
        },
        'negotiable' => package_pricing.negotiable,
      )
  end
end
