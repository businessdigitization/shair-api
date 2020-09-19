require 'rails_helper'

RSpec.describe API::Entities::Package do
  let(:package) { FactoryBot.create(:package, delivery_daterange: (Date.today..7.days.after)) }
  let!(:package_pricing) { FactoryBot.create(:package_pricing, package: package) }
  let!(:package_item) { FactoryBot.create(:package_item, package: package) }
  let(:package_entity) { API::Entities::Package.represent(package) }

  subject { JSON.parse(package_entity.to_json) }

  it 'matches the api specification' do
    expect(subject).
      to eq(
        'id' => package.id,
        'destination' => {
          'id' => package.destination.id,
          'name' => package.destination.name,
          'code' => package.destination.code,
          'city' => {
            'id' => package.destination.city.id,
            'name' => package.destination.city.name,
            'country' => {
              'id' => package.destination.city.country.id,
              'name' => package.destination.city.country.name,
              'code' => package.destination.city.country.code,
            },
          },
        },
        'departure' => {
          'id' => package.departure.id,
          'name' => package.departure.name,
          'code' => package.departure.code,
          'city' => {
            'id' => package.departure.city.id,
            'name' => package.departure.city.name,
            'country' => {
              'id' => package.departure.city.country.id,
              'name' => package.departure.city.country.name,
              'code' => package.departure.city.country.code,
            },
          },
        },
        'delivery_date_lower_bound' => package.delivery_daterange.first.iso8601,
        'delivery_date_upper_bound' => package.delivery_daterange.last.iso8601,
        'dispatcher' => {
          'id' => package.dispatcher.id,
          'name' => package.dispatcher.name,
          'email' => package.dispatcher.email,
        },
        'status' => package.status,
        'description' => package.description,
        'weight' => package.weight,
        'items' => [
          {
            'id' => package_item.id,
            'name' => package_item.name,
            'description' => package_item.description,
            'count' => package_item.count,
          }
        ],
        'pricing' => {
          'id' => package_pricing.id,
          'price' => package_pricing.price,
          'currency' => {
            'name' => package_pricing.currency.name,
            'code' => package_pricing.currency.code,
          },
          'negotiable' => package_pricing.negotiable,
        },
        'preference' => package.preference,
      )
  end
end
