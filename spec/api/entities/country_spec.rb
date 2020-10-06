require 'rails_helper'

RSpec.describe Entities::Country do
  let(:country) { FactoryBot.create(:country) }
  let(:country_entity) { Entities::Country.represent(country) }

  subject { JSON.parse(country_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'name' => country.name,
        'code' => country.code,
      )
  end
end
