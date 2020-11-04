require 'rails_helper'

RSpec.describe Entities::ParcelItem do
  let(:parcel_item) { FactoryBot.create(:parcel_item) }
  let(:parcel_item_entity) { Entities::ParcelItem.represent(parcel_item) }

  subject { JSON.parse(parcel_item_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => parcel_item.id,
        'name' => parcel_item.name,
        'description' => parcel_item.description,
        'count' => parcel_item.count,
      )
  end
end
