require 'rails_helper'

RSpec.describe Entities::Airport do
  let(:airport) { FactoryBot.create(:airport) }
  let(:airport_entity) { Entities::Airport.represent(airport) }

  subject { JSON.parse(airport_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'name' => airport.name,
        'code' => airport.code,
        'city' => {
          'name' => airport.city.name,
          'country' => {
            'name' => airport.city.country.name,
            'code' => airport.city.country.code
          },
        }
      )
  end
end
