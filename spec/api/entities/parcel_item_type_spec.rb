require 'rails_helper'

RSpec.describe Entities::ParcelItemType do
  let(:item_type) { FactoryBot.create(:parcel_item) }
  let(:item_type_entity) { Entities::ParcelItemType.represent(item_type) }

  subject { JSON.parse(item_type_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => item_type.id,
        'name' => item_type.name,
        'description' => item_type.description,
      )
  end
end
