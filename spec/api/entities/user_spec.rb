require 'rails_helper'

RSpec.describe Entities::User do
  let(:user) { FactoryBot.create(:user) }
  let(:user_entity) { Entities::User.represent(user) }

  subject { JSON.parse(user_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'name' => user.name,
        'email' => user.email,
      )
  end
end
