require 'rails_helper'

RSpec.describe API::Entities::Currency do
  let(:currency) { FactoryBot.create(:currency) }
  let(:currency_entity) { API::Entities::Currency.represent(currency) }

  subject { JSON.parse(currency_entity.to_json) }

  it 'matches the api specification' do
    expect(subject).
      to eq(
        'name' => currency.name,
        'code' => currency.code,
      )
  end
end
