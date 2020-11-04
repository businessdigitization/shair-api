require 'rails_helper'

RSpec.describe Entities::Parcel do
  let(:parcel) { FactoryBot.create(:parcel) }
  let!(:parcel_pricing) { FactoryBot.create(:parcel_pricing, parcel: parcel) }
  let!(:parcel_item) { FactoryBot.create(:parcel_item, parcel: parcel) }
  let(:item_type) { parcel_item.item_type }
  let(:parcel_entity) { Entities::Parcel.represent(parcel) }

  subject { JSON.parse(parcel_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => parcel.id,
        'destination' => {
          'name' => parcel.destination.name,
          'code' => parcel.destination.code,
          'city' => {
            'name' => parcel.destination.city.name,
            'country' => {
              'name' => parcel.destination.city.country.name,
              'code' => parcel.destination.city.country.code,
            },
          },
        },
        'origin' => {
          'name' => parcel.origin.name,
          'code' => parcel.origin.code,
          'city' => {
            'name' => parcel.origin.city.name,
            'country' => {
              'name' => parcel.origin.city.country.name,
              'code' => parcel.origin.city.country.code,
            },
          },
        },
        'dispatcher' => {
          'name' => parcel.dispatcher.name,
          'email' => parcel.dispatcher.email,
        },
        'status' => parcel.status,
        'description' => parcel.description,
        'weight' => parcel.weight,
        'items' => [
          {
            'id' => parcel_item.id,
            'name' => parcel_item.name,
            'description' => parcel_item.description,
            'count' => parcel_item.count,
            'item_type' => {
              'id' => item_type.id,
              'name' => item_type.name,
              'description' => item_type.description,
            }
          }
        ],
        'items_categories' => item_type.name,
        'pricing' => {
          'id' => parcel_pricing.id,
          'price' => parcel_pricing.price,
          'currency' => {
            'name' => parcel_pricing.currency.name,
            'code' => parcel_pricing.currency.code,
          },
          'negotiable' => parcel_pricing.negotiable,
        },
        'preference' => parcel.preference,
      )
  end
end
