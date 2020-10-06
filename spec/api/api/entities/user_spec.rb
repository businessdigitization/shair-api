require 'rails_helper'

RSpec.describe API::Entities::User do
  let(:user) { FactoryBot.create(:user) }
  let(:user_entity) { API::Entities::User.represent(user) }

  subject { JSON.parse(user_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'name' => user.name,
        'email' => user.email,
      )
  end
end
