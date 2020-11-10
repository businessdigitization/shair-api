require 'rails_helper'

RSpec.describe AuthenticationService::AuthenticateByUserCredentials do
  describe '.call' do
    let!(:user) { FactoryBot.create(:user)}

    context 'Credentials are valid' do
      subject { described_class.call(user.email, user.password) }

      it 'authenticate and return encoded JWT' do
        expect(subject).not_to eq(nil)
      end
    end

    context 'Credentials are invalid' do
      subject { described_class.call(user.email, 'Habijabi') }

      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end
  end
end
