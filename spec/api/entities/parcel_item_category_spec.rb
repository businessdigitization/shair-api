require 'rails_helper'

RSpec.describe Entities::ParcelItemCategory do
  let(:item_category) { FactoryBot.create(:parcel_item) }
  let(:item_category_entity) { Entities::ParcelItemCategory.represent(item_category) }

  subject { JSON.parse(item_category_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => item_category.id,
        'name' => item_category.name,
        'description' => item_category.description,
      )
  end
end
