require 'rails_helper'

RSpec.describe API::Entities::City do
  let(:city) { FactoryBot.create(:city) }
  let(:city_entity) { API::Entities::City.represent(city) }

  subject { JSON.parse(city_entity.to_json) }

  it 'matches the api specification' do
    expect(subject).
      to eq(
        'id' => city.id,
        'name' => city.name,
        'country' => {
          'id' => city.country.id,
          'name' => city.country.name,
          'code' => city.country.code
        },
      )
  end
end
