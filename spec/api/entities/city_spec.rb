require 'rails_helper'

RSpec.describe Entities::City do
  let(:city) { FactoryBot.create(:city) }
  let(:city_entity) { Entities::City.represent(city) }

  subject { JSON.parse(city_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'name' => city.name,
        'country' => {
          'name' => city.country.name,
          'code' => city.country.code
        },
      )
  end
end
