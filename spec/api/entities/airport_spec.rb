require 'rails_helper'

RSpec.describe API::Entities::Airport do
  let(:airport) { FactoryBot.create(:airport) }
  let(:airport_entity) { API::Entities::Airport.represent(airport) }

  subject { JSON.parse(airport_entity.to_json) }

  it 'matches the api specification' do
    expect(subject).
      to eq(
        'id' => airport.id,
        'name' => airport.name,
        'code' => airport.code,
        'city' => {
          'id' => airport.city.id,
          'name' => airport.city.name,
          'country' => {
            'id' => airport.city.country.id,
            'name' => airport.city.country.name,
            'code' => airport.city.country.code
          },
        }
      )
  end
end
