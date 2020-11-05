require 'rails_helper'

RSpec.describe Entities::ParcelItem do
  let(:parcel_item) { FactoryBot.create(:parcel_item) }
  let(:item_category) { parcel_item.category }
  let(:parcel_item_entity) { Entities::ParcelItem.represent(parcel_item) }

  subject { JSON.parse(parcel_item_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => parcel_item.id,
        'name' => parcel_item.name,
        'description' => parcel_item.description,
        'count' => parcel_item.count,
        'category' => {
          'id' => item_category.id,
          'name' => item_category.name,
          'description' => item_category.description,
        }
      )
  end
end
