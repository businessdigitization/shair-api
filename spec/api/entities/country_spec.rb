require 'rails_helper'

RSpec.describe API::Entities::Country do
  let(:country) { FactoryBot.create(:country) }
  let(:country_entity) { API::Entities::Country.represent(country) }

  subject { JSON.parse(country_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => country.id,
        'name' => country.name,
        'code' => country.code,
      )
  end
end
