require 'rails_helper'

RSpec.describe AuthenticationService::AuthenticateByToken do
  describe '.call' do
    let!(:user) { FactoryBot.create(:user)}
    let!(:auth_header) { generate_auth_header(user) }

    subject { described_class.call(auth_header['Authorization'].split(' ').last) }

    it 'decodes the token and return the user' do
      expect(subject).to eq(user)
    end
  end
end
